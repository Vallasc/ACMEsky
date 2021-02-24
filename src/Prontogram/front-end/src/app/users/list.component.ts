import { Component, OnInit } from '@angular/core';
import { User } from '@app/_models';
import { first } from 'rxjs/operators';

import { AccountService } from '../_services';

@Component({ templateUrl: 'list.component.html' })
export class ListComponent implements OnInit {
    users: User[] = [];

    constructor(private accountService: AccountService) {}

    ngOnInit() {
        this.accountService.getAll().subscribe (user => this.users= user)  
    }
    basicDetails(user) {
  
        const { _id, email, name, password, secondName, username, token} = user;
        return { _id, email, name, password, secondName, username, token } ;
    }
    deleteUser(id: string) {
       
        const user = this.users.find(x => x._id === id);
        this.accountService.delete(id)
           .pipe(first())
           .subscribe(() => this.users = this.users.filter(x => x._id !== id));
    }
}