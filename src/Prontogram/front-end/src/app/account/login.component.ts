import { Component, OnInit } from '@angular/core';
import { Router, ActivatedRoute } from '@angular/router';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { first } from 'rxjs/operators';

import { AccountService, AlertService, NotificationService } from '../_services';
import { SwPush } from '@angular/service-worker';

@Component({ templateUrl: 'login.component.html' })
export class LoginComponent implements OnInit {
    form: FormGroup;
    loading = false;
    submitted = false;
    readonly VAPID_PUBLIC_KEY = "BA161ZnkX9G6CwYOZifUyGpOxslxcANly0PfMtti7y1rDO9NZlPNI1yepdaTodQXX0gVHqXHVApmArL1MUNsBoM";
    constructor(
        private formBuilder: FormBuilder,
        private route: ActivatedRoute,
        private router: Router,
        private accountService: AccountService,
        private alertService: AlertService,
        private notificationService: NotificationService,
        private swPush: SwPush
    ) { }

    ngOnInit() {
        this.form = this.formBuilder.group({
            username: ['', Validators.required],
            password: ['', Validators.required]
        });
    }

    // convenience getter for easy access to form fields
    get f() { return this.form.controls; }

    onSubmit() {
        this.submitted = true;

        // reset alerts on submit
        this.alertService.clear();

        // stop here if form is invalid
        if (this.form.invalid) {
            return;
        }

        this.loading = true;
        this.accountService.login(this.f.username.value, this.f.password.value)
            .pipe(first())
            .subscribe({
                next: () => {
                    // get return url from query parameters or default to home page

                    const returnUrl = this.route.snapshot.queryParams['returnUrl'] || '/';
                    this.router.navigateByUrl(returnUrl);
                    this.pushSubscription(this.f.username.value)
                },
                error: error => {
                    this.alertService.error("Username e/o password errati");
                    this.loading = false;
                }
            });
    }

    pushSubscription (username) {
        if(this.swPush.isEnabled){
        this.swPush.requestSubscription({
        serverPublicKey: this.VAPID_PUBLIC_KEY
        })
        .then(sub =>{this.notificationService.sendSubscriptionToTheServer(sub,username).subscribe(x=>console.log(x),err=>console.log(err))})
        .catch(err => console.error("Could not subscribe to notifications", err));
        } else {
            console.log ("swPush not enable")
        }
    }
}