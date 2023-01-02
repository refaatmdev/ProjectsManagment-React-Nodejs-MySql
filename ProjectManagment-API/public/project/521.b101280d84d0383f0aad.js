(self.webpackChunkmaterialpro=self.webpackChunkmaterialpro||[]).push([[521],{9521:(e,t,r)=>{"use strict";r.r(t),r.d(t,{AuthModule:()=>Y});var o=r(1116),n=r(4258),a=r(1041),i=r(5366),s=r(9948),m=r(9794),l=r(2281),p=r(2693);let c=(()=>{class e{constructor(e){this.httpClient=e}getCompanyDetails(){return this.httpClient.get(`${l.x}/company/getCompanyDetails`).toPromise()}insertCompanyDetails(e){return this.httpClient.post(`${l.x}/company/insertCompanyDetails`,e).toPromise()}}return e.\u0275fac=function(t){return new(t||e)(i.LFG(p.eN))},e.\u0275prov=i.Yz7({token:e,factory:e.\u0275fac,providedIn:"root"}),e})();var u=r(2797),g=r(5965),d=r(3070),f=r(9550),Z=r(4369);function h(e,t){1&e&&(i.TgZ(0,"mat-error"),i._uU(1,"please insert your company name "),i.qZA())}function v(e,t){1&e&&(i.TgZ(0,"mat-error"),i._uU(1,"please insert the owner name "),i.qZA())}function w(e,t){1&e&&(i.TgZ(0,"mat-error"),i._uU(1,"please insert the last name "),i.qZA())}function y(e,t){1&e&&(i.TgZ(0,"mat-error"),i._uU(1,"please insert phone number "),i.qZA())}function q(e,t){1&e&&(i.TgZ(0,"mat-error"),i._uU(1,"please insert your email "),i.qZA())}function A(e,t){1&e&&(i.TgZ(0,"mat-error"),i._uU(1,"please insert password "),i.qZA())}function T(e,t){1&e&&(i.TgZ(0,"mat-error"),i._uU(1," Passwords must match "),i.qZA())}let x=(()=>{class e{constructor(e,t,r){this._companyService=e,this.formBuilder=t,this.router=r}ngOnInit(){this.initForm()}initForm(){this.setUpForm=this.formBuilder.group({company_name:new a.NI("",[a.kI.required]),owner:new a.NI("",[a.kI.required]),lastName:new a.NI("",[a.kI.required]),phone:new a.NI("",[a.kI.required]),email:[null,a.kI.compose([a.kI.required,a.kI.email])],password:["",[a.kI.required,a.kI.min(4)]],confirmPassword:[""]},{validator:e=>{const t=e.controls.confirmPassword;t.errors&&!t.errors.mustMatch||t.setErrors(e.controls.password.value!==t.value?{mustMatch:!0}:null)}})}createCompany(){return e=this,void 0,r=function*(){const{company_name:e,owner:t,lastName:r,phone:o,email:n,password:a}=this.setUpForm.value;if(console.log(this.setUpForm.value),this.setUpForm.invalid)return;const i={company_name:e,owner:t,lastName:r,phone:o,email:n,password:a};(yield this._companyService.insertCompanyDetails(i))&&this.router.navigate(["/"])},new((t=void 0)||(t=Promise))(function(o,n){function a(e){try{s(r.next(e))}catch(t){n(t)}}function i(e){try{s(r.throw(e))}catch(t){n(t)}}function s(e){var r;e.done?o(e.value):(r=e.value,r instanceof t?r:new t(function(e){e(r)})).then(a,i)}s((r=r.apply(e,[])).next())});var e,t,r}}return e.\u0275fac=function(t){return new(t||e)(i.Y36(c),i.Y36(a.qu),i.Y36(n.F0))},e.\u0275cmp=i.Xpm({type:e,selectors:[["app-setup"]],decls:53,vars:8,consts:[[3,"formGroup"],[1,"text-center"],["alt","homepage","src","assets/images/logo-icon.png"],[1,"m-t-0"],["fxLayout","row wrap"],["fxFlex.gt-sm","100","fxFlex.gt-xs","100","fxFlex","100"],["appearance","outline"],["matInput","","type","text","name","company_name","formControlName","company_name","placeholder","Enter your Company Name "],[4,"ngIf"],["matInput","","type","text","name","owner","formControlName","owner","placeholder","Enter the Owner "],["matInput","","type","text","name","lastName","formControlName","lastName","placeholder","Enter the last name "],["matInput","","type","text","name","phone","formControlName","phone","placeholder","Enter your phone "],["matInput","","type","text","name","email","formControlName","email","placeholder","Enter your Email "],["matInput","","type","password","name","password","formControlName","password","placeholder","Enter your Email  Password"],["matInput","","type","password","name","confirmPassword","formControlName","confirmPassword","placeholder","Confirm password"],["mat-raised-button","","color","primary","type","button",1,"btn-block","btn-lg","m-t-20","m-b-20",3,"click"]],template:function(e,t){1&e&&(i.TgZ(0,"form",0),i.TgZ(1,"div",1),i._UZ(2,"img",2),i.TgZ(3,"h4",3),i._uU(4,"\u05d1\u05e8\u05d5\u05db\u05d9\u05dd \u05d4\u05d1\u05d0\u05d9\u05dd \u05dc\u05de\u05e2\u05e8\u05db\u05ea"),i.qZA(),i.TgZ(5,"h5",3),i._uU(6,"PMS"),i.qZA(),i.qZA(),i.TgZ(7,"div",4),i.TgZ(8,"div",5),i.TgZ(9,"mat-form-field",6),i.TgZ(10,"mat-label"),i._uU(11,"company name"),i.qZA(),i._UZ(12,"input",7),i.YNc(13,h,2,0,"mat-error",8),i.qZA(),i.qZA(),i.TgZ(14,"div",5),i.TgZ(15,"mat-form-field",6),i.TgZ(16,"mat-label"),i._uU(17,"Owner Name"),i.qZA(),i._UZ(18,"input",9),i.YNc(19,v,2,0,"mat-error",8),i.qZA(),i.qZA(),i.TgZ(20,"div",5),i.TgZ(21,"mat-form-field",6),i.TgZ(22,"mat-label"),i._uU(23,"Last Name"),i.qZA(),i._UZ(24,"input",10),i.YNc(25,w,2,0,"mat-error",8),i.qZA(),i.qZA(),i.TgZ(26,"div",5),i.TgZ(27,"mat-form-field",6),i.TgZ(28,"mat-label"),i._uU(29,"Phone"),i.qZA(),i._UZ(30,"input",11),i.YNc(31,y,2,0,"mat-error",8),i.qZA(),i.qZA(),i.TgZ(32,"div",5),i.TgZ(33,"mat-form-field",6),i.TgZ(34,"mat-label"),i._uU(35,"Email"),i.qZA(),i._UZ(36,"input",12),i.YNc(37,q,2,0,"mat-error",8),i.qZA(),i.qZA(),i.TgZ(38,"div",5),i.TgZ(39,"mat-form-field",6),i.TgZ(40,"mat-label"),i._uU(41,"Password"),i.qZA(),i._UZ(42,"input",13),i.YNc(43,A,2,0,"mat-error",8),i.qZA(),i.qZA(),i.TgZ(44,"div",5),i.TgZ(45,"mat-form-field",6),i.TgZ(46,"mat-label"),i._uU(47,"Confirm password"),i.qZA(),i._UZ(48,"input",14),i.YNc(49,T,2,0,"mat-error",8),i.qZA(),i.qZA(),i.TgZ(50,"div",5),i.TgZ(51,"button",15),i.NdJ("click",function(){return t.createCompany()}),i._uU(52," Finish "),i.qZA(),i.qZA(),i.qZA(),i.qZA()),2&e&&(i.Q6J("formGroup",t.setUpForm),i.xp6(13),i.Q6J("ngIf",t.setUpForm.get("company_name").invalid),i.xp6(6),i.Q6J("ngIf",t.setUpForm.get("owner").invalid),i.xp6(6),i.Q6J("ngIf",t.setUpForm.get("lastName").invalid),i.xp6(6),i.Q6J("ngIf",t.setUpForm.get("phone").invalid),i.xp6(6),i.Q6J("ngIf",t.setUpForm.get("email").invalid),i.xp6(6),i.Q6J("ngIf",t.setUpForm.get("password").invalid),i.xp6(6),i.Q6J("ngIf",null==t.setUpForm.controls.confirmPassword||null==t.setUpForm.controls.confirmPassword.errors?null:t.setUpForm.controls.confirmPassword.errors.mustMatch))},directives:[a._Y,a.JL,a.sg,g.xw,g.yH,d.KE,d.hX,f.Nt,a.Fj,a.JJ,a.u,o.O5,Z.lW,d.TO],styles:[""]}),e})();var U=function(e,t,r,o){return new(r||(r=Promise))(function(n,a){function i(e){try{m(o.next(e))}catch(t){a(t)}}function s(e){try{m(o.throw(e))}catch(t){a(t)}}function m(e){var t;e.done?n(e.value):(t=e.value,t instanceof r?t:new r(function(e){e(t)})).then(i,s)}m((o=o.apply(e,t||[])).next())})};function _(e,t){if(1&e&&(i.TgZ(0,"div",16),i._uU(1),i.qZA()),2&e){const e=i.oxw(2);i.xp6(1),i.Oqu(e.msg)}}function I(e,t){1&e&&(i.TgZ(0,"mat-error"),i._uU(1,"please insert your email "),i.qZA())}function N(e,t){1&e&&(i.TgZ(0,"mat-error"),i._uU(1,"please insert password "),i.qZA())}function F(e,t){if(1&e){const e=i.EpF();i.TgZ(0,"div",3),i.TgZ(1,"mat-card",4),i.TgZ(2,"mat-card-content"),i.TgZ(3,"form",5),i.TgZ(4,"div",6),i._UZ(5,"img",7),i.TgZ(6,"h4",8),i._uU(7,"Login to PMS"),i.qZA(),i.qZA(),i.YNc(8,_,2,1,"div",9),i.TgZ(9,"div",10),i.TgZ(10,"div",11),i.TgZ(11,"mat-form-field"),i._UZ(12,"input",12),i.YNc(13,I,2,0,"mat-error",13),i.qZA(),i.qZA(),i.TgZ(14,"div",11),i.TgZ(15,"mat-form-field"),i._UZ(16,"input",14),i.YNc(17,N,2,0,"mat-error",13),i.qZA(),i.qZA(),i.TgZ(18,"div",11),i.TgZ(19,"button",15),i.NdJ("click",function(){return i.CHM(e),i.oxw().login()}),i._uU(20," Login "),i.qZA(),i.qZA(),i.qZA(),i.qZA(),i.qZA(),i.qZA(),i.qZA()}if(2&e){const e=i.oxw();i.xp6(3),i.Q6J("formGroup",e.loginForm),i.xp6(5),i.Q6J("ngIf",e.msg),i.xp6(5),i.Q6J("ngIf",e.loginForm.get("email").invalid),i.xp6(4),i.Q6J("ngIf",e.loginForm.get("password").invalid)}}function b(e,t){1&e&&(i.TgZ(0,"div",3),i.TgZ(1,"mat-card",4),i.TgZ(2,"mat-card-content"),i._UZ(3,"app-setup"),i.qZA(),i.qZA(),i.qZA())}const C=[{path:"",component:(()=>{class e{constructor(e,t,r,o,n){this._authService=e,this._tokenService=t,this._companyService=r,this.formBuilder=o,this.router=n,this.msg="",this.setUp=!1,this.initForm()}ngOnInit(){return U(this,void 0,void 0,function*(){0==(yield this.getCompanyDetails()).length&&(this.setUp=!0),this._tokenService.getToken()&&this.router.navigate(["/projects"])})}initForm(){this.loginForm=this.formBuilder.group({email:new a.NI("",[a.kI.required,a.kI.email]),password:new a.NI("",[a.kI.required])})}getCompanyDetails(){return U(this,void 0,void 0,function*(){return yield this._companyService.getCompanyDetails()})}login(){this._authService.login(this.loginForm.value).subscribe(e=>{this.msg=e.message,"redirect"===e.message&&this.router.navigate(["/projects"])})}}return e.\u0275fac=function(t){return new(t||e)(i.Y36(s.e),i.Y36(m.B),i.Y36(c),i.Y36(a.qu),i.Y36(n.F0))},e.\u0275cmp=i.Xpm({type:e,selectors:[["app-login"]],decls:4,vars:2,consts:[[1,"login-register",2,"background-image","url(assets/images/background/login-register.jpg)"],["class","login-register-box",4,"ngIf","ngIfElse"],["setUpTemplate",""],[1,"login-register-box"],[1,"m-t-10"],[3,"formGroup"],[1,"text-center"],["alt","homepage","src","assets/images/logo-icon.png"],[1,"m-t-0"],["class","bg-danger p-10 text-white",4,"ngIf"],["fxLayout","row wrap"],["fxFlex.gt-sm","100","fxFlex.gt-xs","100","fxFlex","100"],["matInput","","type","text","name","email","formControlName","email","placeholder","Enter your Email "],[4,"ngIf"],["matInput","","type","password","name","password","formControlName","password","placeholder","Enter your Email  Password"],["mat-raised-button","","color","primary","type","button",1,"btn-block","btn-lg","m-t-20","m-b-20",3,"click"],[1,"bg-danger","p-10","text-white"]],template:function(e,t){if(1&e&&(i.TgZ(0,"div",0),i.YNc(1,F,21,4,"div",1),i.YNc(2,b,4,0,"ng-template",null,2,i.W1O),i.qZA()),2&e){const e=i.MAs(3);i.xp6(1),i.Q6J("ngIf",!t.setUp)("ngIfElse",e)}},directives:[o.O5,u.a8,u.dn,a._Y,a.JL,a.sg,g.xw,g.yH,d.KE,f.Nt,a.Fj,a.JJ,a.u,Z.lW,d.TO,x],styles:[""]}),e})()}];let k=(()=>{class e{}return e.\u0275fac=function(t){return new(t||e)},e.\u0275mod=i.oAB({type:e}),e.\u0275inj=i.cJS({imports:[[n.Bz.forChild(C)],n.Bz]}),e})();var J=r(5174);let Y=(()=>{class e{}return e.\u0275fac=function(t){return new(t||e)},e.\u0275mod=i.oAB({type:e}),e.\u0275inj=i.cJS({imports:[[o.ez,k,J.m]]}),e})()}}]);