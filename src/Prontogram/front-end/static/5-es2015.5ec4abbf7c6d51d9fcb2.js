(window.webpackJsonp=window.webpackJsonp||[]).push([[5],{jcJX:function(r,e,n){"use strict";n.r(e),n.d(e,"AccountModule",(function(){return q}));var i=n("3Pt+"),t=n("ofXK"),o=n("tyNb"),s=n("J9tS"),b=n("fXoL");let a=(()=>{class r{constructor(r,e){this.router=r,this.accountService=e,this.accountService.userValue&&this.router.navigate(["/"])}}return r.\u0275fac=function(e){return new(e||r)(b.Kb(o.c),b.Kb(s.a))},r.\u0275cmp=b.Eb({type:r,selectors:[["ng-component"]],decls:2,vars:0,consts:[[1,"col-md-6","offset-md-3","mt-5"]],template:function(r,e){1&r&&(b.Nb(0,"div",0),b.Lb(1,"router-outlet"),b.Mb())},directives:[o.g],encapsulation:2}),r})();var c=n("SxV6");function d(r,e){1&r&&(b.Nb(0,"div"),b.jc(1,"Username obbligatorio"),b.Mb())}function u(r,e){if(1&r&&(b.Nb(0,"div",14),b.ic(1,d,2,0,"div",15),b.Mb()),2&r){const r=b.Wb();b.zb(1),b.Zb("ngIf",r.f.username.errors.required)}}function f(r,e){1&r&&(b.Nb(0,"div"),b.jc(1,"Password obbligatoria"),b.Mb())}function m(r,e){if(1&r&&(b.Nb(0,"div",14),b.ic(1,f,2,0,"div",15),b.Mb()),2&r){const r=b.Wb();b.zb(1),b.Zb("ngIf",r.f.password.errors.required)}}function l(r,e){1&r&&b.Lb(0,"span",16)}const g=function(r){return{"is-invalid":r}};function p(r,e){1&r&&(b.Nb(0,"div"),b.jc(1,"Nome obbligatorio"),b.Mb())}function v(r,e){if(1&r&&(b.Nb(0,"div",18),b.ic(1,p,2,0,"div",19),b.Mb()),2&r){const r=b.Wb();b.zb(1),b.Zb("ngIf",r.f.name.errors.required)}}function h(r,e){1&r&&(b.Nb(0,"div"),b.jc(1,"Cognome obbligatorio"),b.Mb())}function N(r,e){if(1&r&&(b.Nb(0,"div",18),b.ic(1,h,2,0,"div",19),b.Mb()),2&r){const r=b.Wb();b.zb(1),b.Zb("ngIf",r.f.secondName.errors.required)}}function M(r,e){1&r&&(b.Nb(0,"div"),b.jc(1,"Username is required"),b.Mb())}function w(r,e){1&r&&(b.Nb(0,"div"),b.jc(1,"L'username deve essere almeno di 6 caratteri"),b.Mb())}function j(r,e){if(1&r&&(b.Nb(0,"div",18),b.ic(1,M,2,0,"div",19),b.ic(2,w,2,0,"div",19),b.Mb()),2&r){const r=b.Wb();b.zb(1),b.Zb("ngIf",r.f.username.errors.required),b.zb(1),b.Zb("ngIf",r.f.username.errors.minlength)}}function z(r,e){1&r&&(b.Nb(0,"div"),b.jc(1,"Password is required"),b.Mb())}function I(r,e){1&r&&(b.Nb(0,"div"),b.jc(1,"La password deve essere almeno di 6 caratteri"),b.Mb())}function Z(r,e){if(1&r&&(b.Nb(0,"div",18),b.ic(1,z,2,0,"div",19),b.ic(2,I,2,0,"div",19),b.Mb()),2&r){const r=b.Wb();b.zb(1),b.Zb("ngIf",r.f.password.errors.required),b.zb(1),b.Zb("ngIf",r.f.password.errors.minlength)}}function S(r,e){1&r&&b.Lb(0,"span",20)}const C=function(r){return{"is-invalid":r}},y=[{path:"",component:a,children:[{path:"login",component:(()=>{class r{constructor(r,e,n,i,t){this.formBuilder=r,this.route=e,this.router=n,this.accountService=i,this.alertService=t,this.loading=!1,this.submitted=!1}ngOnInit(){this.form=this.formBuilder.group({username:["",i.h.required],password:["",i.h.required]})}get f(){return this.form.controls}onSubmit(){this.submitted=!0,this.alertService.clear(),this.form.invalid||(this.loading=!0,this.accountService.login(this.f.username.value,this.f.password.value).pipe(Object(c.a)()).subscribe({next:()=>{this.router.navigateByUrl(this.route.snapshot.queryParams.returnUrl||"/")},error:r=>{this.alertService.error("Username e/o password errati"),this.loading=!1}}))}}return r.\u0275fac=function(e){return new(e||r)(b.Kb(i.b),b.Kb(o.a),b.Kb(o.c),b.Kb(s.a),b.Kb(s.b))},r.\u0275cmp=b.Eb({type:r,selectors:[["ng-component"]],decls:23,vars:11,consts:[["align","center"],[1,"card"],[1,"card-header"],[1,"card-body"],[3,"formGroup","ngSubmit"],[1,"form-group"],["for","username"],["type","text","formControlName","username",1,"form-control",3,"ngClass"],["class","invalid-feedback",4,"ngIf"],["for","password"],["type","password","formControlName","password",1,"form-control",3,"ngClass"],[1,"btn","btn-primary",3,"disabled"],["class","spinner-border spinner-border-sm mr-1",4,"ngIf"],["routerLink","../register",1,"btn","btn-link"],[1,"invalid-feedback"],[4,"ngIf"],[1,"spinner-border","spinner-border-sm","mr-1"]],template:function(r,e){1&r&&(b.Nb(0,"h4",0),b.jc(1,"Benvenuto in Prontogram!"),b.Mb(),b.Nb(2,"div",1),b.Nb(3,"h4",2),b.jc(4,"Login"),b.Mb(),b.Nb(5,"div",3),b.Nb(6,"form",4),b.Ub("ngSubmit",(function(){return e.onSubmit()})),b.Nb(7,"div",5),b.Nb(8,"label",6),b.jc(9,"Username"),b.Mb(),b.Lb(10,"input",7),b.ic(11,u,2,1,"div",8),b.Mb(),b.Nb(12,"div",5),b.Nb(13,"label",9),b.jc(14,"Password"),b.Mb(),b.Lb(15,"input",10),b.ic(16,m,2,1,"div",8),b.Mb(),b.Nb(17,"div",5),b.Nb(18,"button",11),b.ic(19,l,1,0,"span",12),b.jc(20," Login "),b.Mb(),b.Nb(21,"a",13),b.jc(22,"Registrati"),b.Mb(),b.Mb(),b.Mb(),b.Mb(),b.Mb()),2&r&&(b.zb(6),b.Zb("formGroup",e.form),b.zb(4),b.Zb("ngClass",b.cc(7,g,e.submitted&&e.f.username.errors)),b.zb(1),b.Zb("ngIf",e.submitted&&e.f.username.errors),b.zb(4),b.Zb("ngClass",b.cc(9,g,e.submitted&&e.f.password.errors)),b.zb(1),b.Zb("ngIf",e.submitted&&e.f.password.errors),b.zb(2),b.Zb("disabled",e.loading),b.zb(1),b.Zb("ngIf",e.loading))},directives:[i.i,i.f,i.d,i.a,i.e,i.c,t.h,t.j,o.e],encapsulation:2}),r})()},{path:"register",component:(()=>{class r{constructor(r,e,n,i,t){this.formBuilder=r,this.route=e,this.router=n,this.accountService=i,this.alertService=t,this.loading=!1,this.submitted=!1}ngOnInit(){this.form=this.formBuilder.group({name:["",i.h.required],secondName:["",i.h.required],username:["",[i.h.required,i.h.minLength(6)]],password:["",[i.h.required,i.h.minLength(6)]]})}get f(){return this.form.controls}onSubmit(){this.submitted=!0,this.alertService.clear(),this.form.invalid||(this.loading=!0,this.accountService.register(this.form.value).pipe(Object(c.a)()).subscribe({next:()=>{this.alertService.success("Ti sei registrato con successo!",{keepAfterRouteChange:!0}),this.router.navigate(["../login"],{relativeTo:this.route})},error:()=>{this.alertService.error("Username gi\xe0 esistente"),this.loading=!1}}))}}return r.\u0275fac=function(e){return new(e||r)(b.Kb(i.b),b.Kb(o.a),b.Kb(o.c),b.Kb(s.a),b.Kb(s.b))},r.\u0275cmp=b.Eb({type:r,selectors:[["ng-component"]],decls:33,vars:19,consts:[["align","center"],[1,"card"],[1,"card-header"],[1,"card-body"],[3,"formGroup","ngSubmit"],[1,"form-group"],["for","nome"],["type","text","formControlName","name",1,"form-control",3,"ngClass"],["class","invalid-feedback",4,"ngIf"],["for","cognome"],["type","text","formControlName","secondName",1,"form-control",3,"ngClass"],["for","username"],["type","text","formControlName","username",1,"form-control",3,"ngClass"],["for","password"],["type","password","formControlName","password",1,"form-control",3,"ngClass"],[1,"btn","btn-primary",3,"disabled"],["class","spinner-border spinner-border-sm mr-1",4,"ngIf"],["routerLink","../login",1,"btn","btn-link"],[1,"invalid-feedback"],[4,"ngIf"],[1,"spinner-border","spinner-border-sm","mr-1"]],template:function(r,e){1&r&&(b.Nb(0,"h4",0),b.jc(1,"Effettua la registazione per accedere a Prontogram!"),b.Mb(),b.Nb(2,"div",1),b.Nb(3,"h4",2),b.jc(4,"Registazione"),b.Mb(),b.Nb(5,"div",3),b.Nb(6,"form",4),b.Ub("ngSubmit",(function(){return e.onSubmit()})),b.Nb(7,"div",5),b.Nb(8,"label",6),b.jc(9,"Nome"),b.Mb(),b.Lb(10,"input",7),b.ic(11,v,2,1,"div",8),b.Mb(),b.Nb(12,"div",5),b.Nb(13,"label",9),b.jc(14,"Cognome"),b.Mb(),b.Lb(15,"input",10),b.ic(16,N,2,1,"div",8),b.Mb(),b.Nb(17,"div",5),b.Nb(18,"label",11),b.jc(19,"Username"),b.Mb(),b.Lb(20,"input",12),b.ic(21,j,3,2,"div",8),b.Mb(),b.Nb(22,"div",5),b.Nb(23,"label",13),b.jc(24,"Password"),b.Mb(),b.Lb(25,"input",14),b.ic(26,Z,3,2,"div",8),b.Mb(),b.Nb(27,"div",5),b.Nb(28,"button",15),b.ic(29,S,1,0,"span",16),b.jc(30," Registrati "),b.Mb(),b.Nb(31,"a",17),b.jc(32,"Torna alla pagina di login"),b.Mb(),b.Mb(),b.Mb(),b.Mb(),b.Mb()),2&r&&(b.zb(6),b.Zb("formGroup",e.form),b.zb(4),b.Zb("ngClass",b.cc(11,C,e.submitted&&e.f.name.errors)),b.zb(1),b.Zb("ngIf",e.submitted&&e.f.name.errors),b.zb(4),b.Zb("ngClass",b.cc(13,C,e.submitted&&e.f.secondName.errors)),b.zb(1),b.Zb("ngIf",e.submitted&&e.f.secondName.errors),b.zb(4),b.Zb("ngClass",b.cc(15,C,e.submitted&&e.f.username.errors)),b.zb(1),b.Zb("ngIf",e.submitted&&e.f.username.errors),b.zb(4),b.Zb("ngClass",b.cc(17,C,e.submitted&&e.f.password.errors)),b.zb(1),b.Zb("ngIf",e.submitted&&e.f.password.errors),b.zb(2),b.Zb("disabled",e.loading),b.zb(1),b.Zb("ngIf",e.loading))},directives:[i.i,i.f,i.d,i.a,i.e,i.c,t.h,t.j,o.e],encapsulation:2}),r})()}]}];let L=(()=>{class r{}return r.\u0275mod=b.Ib({type:r}),r.\u0275inj=b.Hb({factory:function(e){return new(e||r)},imports:[[o.f.forChild(y)],o.f]}),r})(),q=(()=>{class r{}return r.\u0275mod=b.Ib({type:r}),r.\u0275inj=b.Hb({factory:function(e){return new(e||r)},imports:[[t.b,i.g,L]]}),r})()}}]);