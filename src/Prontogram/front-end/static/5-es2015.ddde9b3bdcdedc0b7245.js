(window.webpackJsonp=window.webpackJsonp||[]).push([[5],{jcJX:function(e,r,n){"use strict";n.r(r),n.d(r,"AccountModule",(function(){return U}));var t=n("3Pt+"),i=n("ofXK"),o=n("tyNb"),s=n("J9tS"),b=n("fXoL");let a=(()=>{class e{constructor(e,r){this.router=e,this.accountService=r,this.accountService.userValue&&this.router.navigate(["/"])}}return e.\u0275fac=function(r){return new(r||e)(b.Ib(o.c),b.Ib(s.a))},e.\u0275cmp=b.Cb({type:e,selectors:[["ng-component"]],decls:2,vars:0,consts:[[1,"col-md-6","offset-md-3","mt-5"]],template:function(e,r){1&e&&(b.Lb(0,"div",0),b.Jb(1,"router-outlet"),b.Kb())},directives:[o.g],encapsulation:2}),e})();var c=n("SxV6");function d(e,r){1&e&&(b.Lb(0,"div"),b.fc(1,"Username obbligatorio"),b.Kb())}function f(e,r){if(1&e&&(b.Lb(0,"div",14),b.ec(1,d,2,0,"div",15),b.Kb()),2&e){const e=b.Ub();b.xb(1),b.Vb("ngIf",e.f.username.errors.required)}}function u(e,r){1&e&&(b.Lb(0,"div"),b.fc(1,"Password obbligatoria"),b.Kb())}function m(e,r){if(1&e&&(b.Lb(0,"div",14),b.ec(1,u,2,0,"div",15),b.Kb()),2&e){const e=b.Ub();b.xb(1),b.Vb("ngIf",e.f.password.errors.required)}}function l(e,r){1&e&&b.Jb(0,"span",16)}const g=function(e){return{"is-invalid":e}};function p(e,r){1&e&&(b.Lb(0,"div"),b.fc(1,"Nome obbligatorio"),b.Kb())}function v(e,r){if(1&e&&(b.Lb(0,"div",18),b.ec(1,p,2,0,"div",19),b.Kb()),2&e){const e=b.Ub();b.xb(1),b.Vb("ngIf",e.f.name.errors.required)}}function h(e,r){1&e&&(b.Lb(0,"div"),b.fc(1,"Cognome obbligatorio"),b.Kb())}function L(e,r){if(1&e&&(b.Lb(0,"div",18),b.ec(1,h,2,0,"div",19),b.Kb()),2&e){const e=b.Ub();b.xb(1),b.Vb("ngIf",e.f.secondName.errors.required)}}function K(e,r){1&e&&(b.Lb(0,"div"),b.fc(1,"Username is required"),b.Kb())}function I(e,r){1&e&&(b.Lb(0,"div"),b.fc(1,"L'username deve essere almeno di 6 caratteri"),b.Kb())}function w(e,r){if(1&e&&(b.Lb(0,"div",18),b.ec(1,K,2,0,"div",19),b.ec(2,I,2,0,"div",19),b.Kb()),2&e){const e=b.Ub();b.xb(1),b.Vb("ngIf",e.f.username.errors.required),b.xb(1),b.Vb("ngIf",e.f.username.errors.minlength)}}function x(e,r){1&e&&(b.Lb(0,"div"),b.fc(1,"Password is required"),b.Kb())}function V(e,r){1&e&&(b.Lb(0,"div"),b.fc(1,"La password deve essere almeno di 6 caratteri"),b.Kb())}function C(e,r){if(1&e&&(b.Lb(0,"div",18),b.ec(1,x,2,0,"div",19),b.ec(2,V,2,0,"div",19),b.Kb()),2&e){const e=b.Ub();b.xb(1),b.Vb("ngIf",e.f.password.errors.required),b.xb(1),b.Vb("ngIf",e.f.password.errors.minlength)}}function S(e,r){1&e&&b.Jb(0,"span",20)}const y=function(e){return{"is-invalid":e}},q=[{path:"",component:a,children:[{path:"login",component:(()=>{class e{constructor(e,r,n,t,i){this.formBuilder=e,this.route=r,this.router=n,this.accountService=t,this.alertService=i,this.loading=!1,this.submitted=!1}ngOnInit(){this.form=this.formBuilder.group({username:["",t.h.required],password:["",t.h.required]})}get f(){return this.form.controls}onSubmit(){this.submitted=!0,this.alertService.clear(),this.form.invalid||(this.loading=!0,this.accountService.login(this.f.username.value,this.f.password.value).pipe(Object(c.a)()).subscribe({next:()=>{this.router.navigateByUrl(this.route.snapshot.queryParams.returnUrl||"/")},error:e=>{this.alertService.error("Username e/o password errati"),this.loading=!1}}))}}return e.\u0275fac=function(r){return new(r||e)(b.Ib(t.b),b.Ib(o.a),b.Ib(o.c),b.Ib(s.a),b.Ib(s.b))},e.\u0275cmp=b.Cb({type:e,selectors:[["ng-component"]],decls:23,vars:11,consts:[["align","center"],[1,"card"],[1,"card-header"],[1,"card-body"],[3,"formGroup","ngSubmit"],[1,"form-group"],["for","username"],["type","text","formControlName","username",1,"form-control",3,"ngClass"],["class","invalid-feedback",4,"ngIf"],["for","password"],["type","password","formControlName","password",1,"form-control",3,"ngClass"],[1,"btn","btn-primary",3,"disabled"],["class","spinner-border spinner-border-sm mr-1",4,"ngIf"],["routerLink","../register",1,"btn","btn-link"],[1,"invalid-feedback"],[4,"ngIf"],[1,"spinner-border","spinner-border-sm","mr-1"]],template:function(e,r){1&e&&(b.Lb(0,"h4",0),b.fc(1,"Benvenuto in Prontogram!"),b.Kb(),b.Lb(2,"div",1),b.Lb(3,"h4",2),b.fc(4,"Login"),b.Kb(),b.Lb(5,"div",3),b.Lb(6,"form",4),b.Sb("ngSubmit",(function(){return r.onSubmit()})),b.Lb(7,"div",5),b.Lb(8,"label",6),b.fc(9,"Username"),b.Kb(),b.Jb(10,"input",7),b.ec(11,f,2,1,"div",8),b.Kb(),b.Lb(12,"div",5),b.Lb(13,"label",9),b.fc(14,"Password"),b.Kb(),b.Jb(15,"input",10),b.ec(16,m,2,1,"div",8),b.Kb(),b.Lb(17,"div",5),b.Lb(18,"button",11),b.ec(19,l,1,0,"span",12),b.fc(20," Login "),b.Kb(),b.Lb(21,"a",13),b.fc(22,"Registrati"),b.Kb(),b.Kb(),b.Kb(),b.Kb(),b.Kb()),2&e&&(b.xb(6),b.Vb("formGroup",r.form),b.xb(4),b.Vb("ngClass",b.Yb(7,g,r.submitted&&r.f.username.errors)),b.xb(1),b.Vb("ngIf",r.submitted&&r.f.username.errors),b.xb(4),b.Vb("ngClass",b.Yb(9,g,r.submitted&&r.f.password.errors)),b.xb(1),b.Vb("ngIf",r.submitted&&r.f.password.errors),b.xb(2),b.Vb("disabled",r.loading),b.xb(1),b.Vb("ngIf",r.loading))},directives:[t.i,t.f,t.d,t.a,t.e,t.c,i.h,i.j,o.e],encapsulation:2}),e})()},{path:"register",component:(()=>{class e{constructor(e,r,n,t,i){this.formBuilder=e,this.route=r,this.router=n,this.accountService=t,this.alertService=i,this.loading=!1,this.submitted=!1}ngOnInit(){this.form=this.formBuilder.group({name:["",t.h.required],secondName:["",t.h.required],username:["",[t.h.required,t.h.minLength(6)]],password:["",[t.h.required,t.h.minLength(6)]]})}get f(){return this.form.controls}onSubmit(){this.submitted=!0,this.alertService.clear(),this.form.invalid||(this.loading=!0,this.accountService.register(this.form.value).pipe(Object(c.a)()).subscribe({next:()=>{this.alertService.success("Ti sei registrato con successo!",{keepAfterRouteChange:!0}),this.router.navigate(["../login"],{relativeTo:this.route})},error:()=>{this.alertService.error("Username gi\xe0 esistente"),this.loading=!1}}))}}return e.\u0275fac=function(r){return new(r||e)(b.Ib(t.b),b.Ib(o.a),b.Ib(o.c),b.Ib(s.a),b.Ib(s.b))},e.\u0275cmp=b.Cb({type:e,selectors:[["ng-component"]],decls:33,vars:19,consts:[["align","center"],[1,"card"],[1,"card-header"],[1,"card-body"],[3,"formGroup","ngSubmit"],[1,"form-group"],["for","nome"],["type","text","formControlName","name",1,"form-control",3,"ngClass"],["class","invalid-feedback",4,"ngIf"],["for","cognome"],["type","text","formControlName","secondName",1,"form-control",3,"ngClass"],["for","username"],["type","text","formControlName","username",1,"form-control",3,"ngClass"],["for","password"],["type","password","formControlName","password",1,"form-control",3,"ngClass"],[1,"btn","btn-primary",3,"disabled"],["class","spinner-border spinner-border-sm mr-1",4,"ngIf"],["routerLink","../login",1,"btn","btn-link"],[1,"invalid-feedback"],[4,"ngIf"],[1,"spinner-border","spinner-border-sm","mr-1"]],template:function(e,r){1&e&&(b.Lb(0,"h4",0),b.fc(1,"Effettua la registazione per accedere a Prontogram!"),b.Kb(),b.Lb(2,"div",1),b.Lb(3,"h4",2),b.fc(4,"Registazione"),b.Kb(),b.Lb(5,"div",3),b.Lb(6,"form",4),b.Sb("ngSubmit",(function(){return r.onSubmit()})),b.Lb(7,"div",5),b.Lb(8,"label",6),b.fc(9,"Nome"),b.Kb(),b.Jb(10,"input",7),b.ec(11,v,2,1,"div",8),b.Kb(),b.Lb(12,"div",5),b.Lb(13,"label",9),b.fc(14,"Cognome"),b.Kb(),b.Jb(15,"input",10),b.ec(16,L,2,1,"div",8),b.Kb(),b.Lb(17,"div",5),b.Lb(18,"label",11),b.fc(19,"Username"),b.Kb(),b.Jb(20,"input",12),b.ec(21,w,3,2,"div",8),b.Kb(),b.Lb(22,"div",5),b.Lb(23,"label",13),b.fc(24,"Password"),b.Kb(),b.Jb(25,"input",14),b.ec(26,C,3,2,"div",8),b.Kb(),b.Lb(27,"div",5),b.Lb(28,"button",15),b.ec(29,S,1,0,"span",16),b.fc(30," Registrati "),b.Kb(),b.Lb(31,"a",17),b.fc(32,"Torna alla pagina di login"),b.Kb(),b.Kb(),b.Kb(),b.Kb(),b.Kb()),2&e&&(b.xb(6),b.Vb("formGroup",r.form),b.xb(4),b.Vb("ngClass",b.Yb(11,y,r.submitted&&r.f.name.errors)),b.xb(1),b.Vb("ngIf",r.submitted&&r.f.name.errors),b.xb(4),b.Vb("ngClass",b.Yb(13,y,r.submitted&&r.f.secondName.errors)),b.xb(1),b.Vb("ngIf",r.submitted&&r.f.secondName.errors),b.xb(4),b.Vb("ngClass",b.Yb(15,y,r.submitted&&r.f.username.errors)),b.xb(1),b.Vb("ngIf",r.submitted&&r.f.username.errors),b.xb(4),b.Vb("ngClass",b.Yb(17,y,r.submitted&&r.f.password.errors)),b.xb(1),b.Vb("ngIf",r.submitted&&r.f.password.errors),b.xb(2),b.Vb("disabled",r.loading),b.xb(1),b.Vb("ngIf",r.loading))},directives:[t.i,t.f,t.d,t.a,t.e,t.c,i.h,i.j,o.e],encapsulation:2}),e})()}]}];let N=(()=>{class e{}return e.\u0275mod=b.Gb({type:e}),e.\u0275inj=b.Fb({factory:function(r){return new(r||e)},imports:[[o.f.forChild(q)],o.f]}),e})(),U=(()=>{class e{}return e.\u0275mod=b.Gb({type:e}),e.\u0275inj=b.Fb({factory:function(r){return new(r||e)},imports:[[i.b,t.g,N]]}),e})()}}]);