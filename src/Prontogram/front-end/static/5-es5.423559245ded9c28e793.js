!function(){function e(e,r){for(var n=0;n<r.length;n++){var i=r[n];i.enumerable=i.enumerable||!1,i.configurable=!0,"value"in i&&(i.writable=!0),Object.defineProperty(e,i.key,i)}}function r(r,n,i){return n&&e(r.prototype,n),i&&e(r,i),r}function n(e,r){if(!(e instanceof r))throw new TypeError("Cannot call a class as a function")}(window.webpackJsonp=window.webpackJsonp||[]).push([[5],{jcJX:function(e,i,t){"use strict";t.r(i),t.d(i,"AccountModule",(function(){return E}));var o,s=t("3Pt+"),b=t("ofXK"),a=t("tyNb"),c=t("J9tS"),u=t("fXoL"),d=((o=function e(r,i){n(this,e),this.router=r,this.accountService=i,this.accountService.userValue&&this.router.navigate(["/"])}).\u0275fac=function(e){return new(e||o)(u.Kb(a.c),u.Kb(c.a))},o.\u0275cmp=u.Eb({type:o,selectors:[["ng-component"]],decls:2,vars:0,consts:[[1,"col-md-6","offset-md-3","mt-5"]],template:function(e,r){1&e&&(u.Nb(0,"div",0),u.Lb(1,"router-outlet"),u.Mb())},directives:[a.g],encapsulation:2}),o),f=t("SxV6"),l=t("Jho9");function m(e,r){1&e&&(u.Nb(0,"div"),u.jc(1,"Username obbligatorio"),u.Mb())}function g(e,r){if(1&e&&(u.Nb(0,"div",14),u.ic(1,m,2,0,"div",15),u.Mb()),2&e){var n=u.Wb();u.zb(1),u.Zb("ngIf",n.f.username.errors.required)}}function p(e,r){1&e&&(u.Nb(0,"div"),u.jc(1,"Password obbligatoria"),u.Mb())}function v(e,r){if(1&e&&(u.Nb(0,"div",14),u.ic(1,p,2,0,"div",15),u.Mb()),2&e){var n=u.Wb();u.zb(1),u.Zb("ngIf",n.f.password.errors.required)}}function h(e,r){1&e&&u.Lb(0,"span",16)}var N=function(e){return{"is-invalid":e}};function M(e,r){1&e&&(u.Nb(0,"div"),u.jc(1,"Nome obbligatorio"),u.Mb())}function w(e,r){if(1&e&&(u.Nb(0,"div",18),u.ic(1,M,2,0,"div",19),u.Mb()),2&e){var n=u.Wb();u.zb(1),u.Zb("ngIf",n.f.name.errors.required)}}function y(e,r){1&e&&(u.Nb(0,"div"),u.jc(1,"Cognome obbligatorio"),u.Mb())}function I(e,r){if(1&e&&(u.Nb(0,"div",18),u.ic(1,y,2,0,"div",19),u.Mb()),2&e){var n=u.Wb();u.zb(1),u.Zb("ngIf",n.f.secondName.errors.required)}}function j(e,r){1&e&&(u.Nb(0,"div"),u.jc(1,"Username is required"),u.Mb())}function S(e,r){1&e&&(u.Nb(0,"div"),u.jc(1,"L'username deve essere almeno di 6 caratteri"),u.Mb())}function Z(e,r){if(1&e&&(u.Nb(0,"div",18),u.ic(1,j,2,0,"div",19),u.ic(2,S,2,0,"div",19),u.Mb()),2&e){var n=u.Wb();u.zb(1),u.Zb("ngIf",n.f.username.errors.required),u.zb(1),u.Zb("ngIf",n.f.username.errors.minlength)}}function z(e,r){1&e&&(u.Nb(0,"div"),u.jc(1,"Password is required"),u.Mb())}function C(e,r){1&e&&(u.Nb(0,"div"),u.jc(1,"La password deve essere almeno di 6 caratteri"),u.Mb())}function L(e,r){if(1&e&&(u.Nb(0,"div",18),u.ic(1,z,2,0,"div",19),u.ic(2,C,2,0,"div",19),u.Mb()),2&e){var n=u.Wb();u.zb(1),u.Zb("ngIf",n.f.password.errors.required),u.zb(1),u.Zb("ngIf",n.f.password.errors.minlength)}}function k(e,r){1&e&&u.Lb(0,"span",20)}var P,K,q,U,B=function(e){return{"is-invalid":e}},x=[{path:"",component:d,children:[{path:"login",component:(K=function(){function e(r,i,t,o,s,b,a){n(this,e),this.formBuilder=r,this.route=i,this.router=t,this.accountService=o,this.alertService=s,this.notificationService=b,this.swPush=a,this.loading=!1,this.submitted=!1,this.VAPID_PUBLIC_KEY="BA161ZnkX9G6CwYOZifUyGpOxslxcANly0PfMtti7y1rDO9NZlPNI1yepdaTodQXX0gVHqXHVApmArL1MUNsBoM"}return r(e,[{key:"ngOnInit",value:function(){this.form=this.formBuilder.group({username:["",s.h.required],password:["",s.h.required]})}},{key:"f",get:function(){return this.form.controls}},{key:"onSubmit",value:function(){var e=this;this.submitted=!0,this.alertService.clear(),this.form.invalid||(this.loading=!0,this.accountService.login(this.f.username.value,this.f.password.value).pipe(Object(f.a)()).subscribe({next:function(){e.router.navigateByUrl(e.route.snapshot.queryParams.returnUrl||"/"),e.pushSubscription(e.f.username.value)},error:function(r){e.alertService.error("Username e/o password errati"),e.loading=!1}}))}},{key:"pushSubscription",value:function(e){var r=this;this.swPush.isEnabled?this.swPush.requestSubscription({serverPublicKey:this.VAPID_PUBLIC_KEY}).then((function(n){r.notificationService.sendSubscriptionToTheServer(n,e).subscribe((function(e){return console.log(e)}),(function(e){return console.log(e)}))})).catch((function(e){return console.error("Could not subscribe to notifications",e)})):console.log("swPush not enable")}}]),e}(),K.\u0275fac=function(e){return new(e||K)(u.Kb(s.b),u.Kb(a.a),u.Kb(a.c),u.Kb(c.a),u.Kb(c.b),u.Kb(c.c),u.Kb(l.b))},K.\u0275cmp=u.Eb({type:K,selectors:[["ng-component"]],decls:23,vars:11,consts:[["align","center"],[1,"card"],[1,"card-header"],[1,"card-body"],[3,"formGroup","ngSubmit"],[1,"form-group"],["for","username"],["type","text","formControlName","username",1,"form-control",3,"ngClass"],["class","invalid-feedback",4,"ngIf"],["for","password"],["type","password","formControlName","password",1,"form-control",3,"ngClass"],[1,"btn","btn-primary",3,"disabled"],["class","spinner-border spinner-border-sm mr-1",4,"ngIf"],["routerLink","../register",1,"btn","btn-link"],[1,"invalid-feedback"],[4,"ngIf"],[1,"spinner-border","spinner-border-sm","mr-1"]],template:function(e,r){1&e&&(u.Nb(0,"h4",0),u.jc(1,"Benvenuto in Prontogram!"),u.Mb(),u.Nb(2,"div",1),u.Nb(3,"h4",2),u.jc(4,"Login"),u.Mb(),u.Nb(5,"div",3),u.Nb(6,"form",4),u.Ub("ngSubmit",(function(){return r.onSubmit()})),u.Nb(7,"div",5),u.Nb(8,"label",6),u.jc(9,"Username"),u.Mb(),u.Lb(10,"input",7),u.ic(11,g,2,1,"div",8),u.Mb(),u.Nb(12,"div",5),u.Nb(13,"label",9),u.jc(14,"Password"),u.Mb(),u.Lb(15,"input",10),u.ic(16,v,2,1,"div",8),u.Mb(),u.Nb(17,"div",5),u.Nb(18,"button",11),u.ic(19,h,1,0,"span",12),u.jc(20," Login "),u.Mb(),u.Nb(21,"a",13),u.jc(22,"Registrati"),u.Mb(),u.Mb(),u.Mb(),u.Mb(),u.Mb()),2&e&&(u.zb(6),u.Zb("formGroup",r.form),u.zb(4),u.Zb("ngClass",u.cc(7,N,r.submitted&&r.f.username.errors)),u.zb(1),u.Zb("ngIf",r.submitted&&r.f.username.errors),u.zb(4),u.Zb("ngClass",u.cc(9,N,r.submitted&&r.f.password.errors)),u.zb(1),u.Zb("ngIf",r.submitted&&r.f.password.errors),u.zb(2),u.Zb("disabled",r.loading),u.zb(1),u.Zb("ngIf",r.loading))},directives:[s.i,s.f,s.d,s.a,s.e,s.c,b.h,b.j,a.e],encapsulation:2}),K)},{path:"register",component:(P=function(){function e(r,i,t,o,s){n(this,e),this.formBuilder=r,this.route=i,this.router=t,this.accountService=o,this.alertService=s,this.loading=!1,this.submitted=!1}return r(e,[{key:"ngOnInit",value:function(){this.form=this.formBuilder.group({name:["",s.h.required],secondName:["",s.h.required],username:["",[s.h.required,s.h.minLength(6)]],password:["",[s.h.required,s.h.minLength(6)]]})}},{key:"f",get:function(){return this.form.controls}},{key:"onSubmit",value:function(){var e=this;this.submitted=!0,this.alertService.clear(),this.form.invalid||(this.loading=!0,this.accountService.register(this.form.value).pipe(Object(f.a)()).subscribe({next:function(){e.alertService.success("Ti sei registrato con successo!",{keepAfterRouteChange:!0}),e.router.navigate(["../login"],{relativeTo:e.route})},error:function(){e.alertService.error("Username gi\xe0 esistente"),e.loading=!1}}))}}]),e}(),P.\u0275fac=function(e){return new(e||P)(u.Kb(s.b),u.Kb(a.a),u.Kb(a.c),u.Kb(c.a),u.Kb(c.b))},P.\u0275cmp=u.Eb({type:P,selectors:[["ng-component"]],decls:33,vars:19,consts:[["align","center"],[1,"card"],[1,"card-header"],[1,"card-body"],[3,"formGroup","ngSubmit"],[1,"form-group"],["for","nome"],["type","text","formControlName","name",1,"form-control",3,"ngClass"],["class","invalid-feedback",4,"ngIf"],["for","cognome"],["type","text","formControlName","secondName",1,"form-control",3,"ngClass"],["for","username"],["type","text","formControlName","username",1,"form-control",3,"ngClass"],["for","password"],["type","password","formControlName","password",1,"form-control",3,"ngClass"],[1,"btn","btn-primary",3,"disabled"],["class","spinner-border spinner-border-sm mr-1",4,"ngIf"],["routerLink","../login",1,"btn","btn-link"],[1,"invalid-feedback"],[4,"ngIf"],[1,"spinner-border","spinner-border-sm","mr-1"]],template:function(e,r){1&e&&(u.Nb(0,"h4",0),u.jc(1,"Effettua la registazione per accedere a Prontogram!"),u.Mb(),u.Nb(2,"div",1),u.Nb(3,"h4",2),u.jc(4,"Registazione"),u.Mb(),u.Nb(5,"div",3),u.Nb(6,"form",4),u.Ub("ngSubmit",(function(){return r.onSubmit()})),u.Nb(7,"div",5),u.Nb(8,"label",6),u.jc(9,"Nome"),u.Mb(),u.Lb(10,"input",7),u.ic(11,w,2,1,"div",8),u.Mb(),u.Nb(12,"div",5),u.Nb(13,"label",9),u.jc(14,"Cognome"),u.Mb(),u.Lb(15,"input",10),u.ic(16,I,2,1,"div",8),u.Mb(),u.Nb(17,"div",5),u.Nb(18,"label",11),u.jc(19,"Username"),u.Mb(),u.Lb(20,"input",12),u.ic(21,Z,3,2,"div",8),u.Mb(),u.Nb(22,"div",5),u.Nb(23,"label",13),u.jc(24,"Password"),u.Mb(),u.Lb(25,"input",14),u.ic(26,L,3,2,"div",8),u.Mb(),u.Nb(27,"div",5),u.Nb(28,"button",15),u.ic(29,k,1,0,"span",16),u.jc(30," Registrati "),u.Mb(),u.Nb(31,"a",17),u.jc(32,"Torna alla pagina di login"),u.Mb(),u.Mb(),u.Mb(),u.Mb(),u.Mb()),2&e&&(u.zb(6),u.Zb("formGroup",r.form),u.zb(4),u.Zb("ngClass",u.cc(11,B,r.submitted&&r.f.name.errors)),u.zb(1),u.Zb("ngIf",r.submitted&&r.f.name.errors),u.zb(4),u.Zb("ngClass",u.cc(13,B,r.submitted&&r.f.secondName.errors)),u.zb(1),u.Zb("ngIf",r.submitted&&r.f.secondName.errors),u.zb(4),u.Zb("ngClass",u.cc(15,B,r.submitted&&r.f.username.errors)),u.zb(1),u.Zb("ngIf",r.submitted&&r.f.username.errors),u.zb(4),u.Zb("ngClass",u.cc(17,B,r.submitted&&r.f.password.errors)),u.zb(1),u.Zb("ngIf",r.submitted&&r.f.password.errors),u.zb(2),u.Zb("disabled",r.loading),u.zb(1),u.Zb("ngIf",r.loading))},directives:[s.i,s.f,s.d,s.a,s.e,s.c,b.h,b.j,a.e],encapsulation:2}),P)}]}],A=((U=function e(){n(this,e)}).\u0275mod=u.Ib({type:U}),U.\u0275inj=u.Hb({factory:function(e){return new(e||U)},imports:[[a.f.forChild(x)],a.f]}),U),E=((q=function e(){n(this,e)}).\u0275mod=u.Ib({type:q}),q.\u0275inj=u.Hb({factory:function(e){return new(e||q)},imports:[[b.b,s.g,A]]}),q)}}])}();