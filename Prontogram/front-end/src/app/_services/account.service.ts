import { Injectable } from '@angular/core';
import { Router } from '@angular/router';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { BehaviorSubject, Observable } from 'rxjs';
import { map } from 'rxjs/operators';

import { environment } from '../../environments/environment';
import { User } from '../_models';

@Injectable({ providedIn: 'root' })
export class AccountService {
    private userSubject: BehaviorSubject<User>;
    public user: Observable<User>;
    private header: HttpHeaders 

    constructor(
        private router: Router,
        private http: HttpClient,
        
    ) {
        this.userSubject = new BehaviorSubject<User>(JSON.parse(localStorage.getItem('user')));
        this.user = this.userSubject.asObservable();
       
    }

    public get userValue(): User {
        return this.userSubject.value;
    }

    isLoggedIn() {
        return this.header.get('auth-token') === this.userValue.token;
    }

    login(username, password) {
        return this.http.post<User>(`${environment.apiUrl}/user/login`, { username, password })
        .pipe(map(user => {
            this.userSubject.next(user);
           /* this.header = new HttpHeaders().set(
                "auth-token",
                user.token
              );
               // store user details and jwt token in local storage to keep user logged in between page refreshes
            localStorage.setItem('user', JSON.stringify(user));*/
            console.log ("user token: "+ user.token);
            return user;
        }));
    }

    logout() {
        this.userSubject.next(null);
        this.router.navigate(['/account/login']);
    }

    register(user: User) {
        return this.http.post(`${environment.apiUrl}/user/register`, user);
    }

    createUser(user: User) {
        return this.http.post(`${environment.apiUrl}/posts`, user, {headers: this.getheader ()});
    }

    getAll() {
        return this.http.get<User[]>(`${environment.apiUrl}/gets`, {headers: this.getheader ()}); 
    }

    getById(id: string) {
        return  this.http.get<User>(`${environment.apiUrl}/gets/${id}`, {headers: this.getheader ()});
    }

    update(id, params) {
        return this.http.patch(`${environment.apiUrl}/posts/${id}`, params, {headers: this.getheader ()});
            /*.pipe(map(x => {
                // update stored user if the logged in user updated their own record
                if (id == this.userValue._id) {
                    // update local storage
                    const user = { ...this.userValue, ...params };
                    localStorage.setItem('user', JSON.stringify(user));

                    // publish updated user to subscribers
                    this.userSubject.next(user);
                }
                return x; 
            }));*/
    }

    delete(id: string) {
        return this.http.delete(`${environment.apiUrl}/posts/${id}`, {headers: this.getheader ()})
            .pipe(map(x => {
                // auto logout if the logged in user deleted their own record
                if (id == this.userValue._id) {
                    this.logout();
                }
                return x;
            }));
    }

    getheader (): HttpHeaders {
       return this.header = new HttpHeaders().set(
            "auth-token",
            this.userSubject.value.token
          );
    }
}