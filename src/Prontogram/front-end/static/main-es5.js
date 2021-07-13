(function () {
  function _toConsumableArray(arr) { return _arrayWithoutHoles(arr) || _iterableToArray(arr) || _unsupportedIterableToArray(arr) || _nonIterableSpread(); }

  function _nonIterableSpread() { throw new TypeError("Invalid attempt to spread non-iterable instance.\nIn order to be iterable, non-array objects must have a [Symbol.iterator]() method."); }

  function _unsupportedIterableToArray(o, minLen) { if (!o) return; if (typeof o === "string") return _arrayLikeToArray(o, minLen); var n = Object.prototype.toString.call(o).slice(8, -1); if (n === "Object" && o.constructor) n = o.constructor.name; if (n === "Map" || n === "Set") return Array.from(o); if (n === "Arguments" || /^(?:Ui|I)nt(?:8|16|32)(?:Clamped)?Array$/.test(n)) return _arrayLikeToArray(o, minLen); }

  function _iterableToArray(iter) { if (typeof Symbol !== "undefined" && Symbol.iterator in Object(iter)) return Array.from(iter); }

  function _arrayWithoutHoles(arr) { if (Array.isArray(arr)) return _arrayLikeToArray(arr); }

  function _arrayLikeToArray(arr, len) { if (len == null || len > arr.length) len = arr.length; for (var i = 0, arr2 = new Array(len); i < len; i++) { arr2[i] = arr[i]; } return arr2; }

  function _defineProperty(obj, key, value) { if (key in obj) { Object.defineProperty(obj, key, { value: value, enumerable: true, configurable: true, writable: true }); } else { obj[key] = value; } return obj; }

  function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

  function _defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } }

  function _createClass(Constructor, protoProps, staticProps) { if (protoProps) _defineProperties(Constructor.prototype, protoProps); if (staticProps) _defineProperties(Constructor, staticProps); return Constructor; }

  (window["webpackJsonp"] = window["webpackJsonp"] || []).push([["main"], {
    /***/
    "./$$_lazy_route_resource lazy recursive":
    /*!******************************************************!*\
      !*** ./$$_lazy_route_resource lazy namespace object ***!
      \******************************************************/

    /*! no static exports found */

    /***/
    function $$_lazy_route_resourceLazyRecursive(module, exports) {
      function webpackEmptyAsyncContext(req) {
        // Here Promise.resolve().then() is used instead of new Promise() to prevent
        // uncaught exception popping up in devtools
        return Promise.resolve().then(function () {
          var e = new Error("Cannot find module '" + req + "'");
          e.code = 'MODULE_NOT_FOUND';
          throw e;
        });
      }

      webpackEmptyAsyncContext.keys = function () {
        return [];
      };

      webpackEmptyAsyncContext.resolve = webpackEmptyAsyncContext;
      module.exports = webpackEmptyAsyncContext;
      webpackEmptyAsyncContext.id = "./$$_lazy_route_resource lazy recursive";
      /***/
    },

    /***/
    "./src/app/_components/alert.component.ts":
    /*!************************************************!*\
      !*** ./src/app/_components/alert.component.ts ***!
      \************************************************/

    /*! exports provided: AlertComponent */

    /***/
    function srcApp_componentsAlertComponentTs(module, __webpack_exports__, __webpack_require__) {
      "use strict";

      __webpack_require__.r(__webpack_exports__);
      /* harmony export (binding) */


      __webpack_require__.d(__webpack_exports__, "AlertComponent", function () {
        return AlertComponent;
      });
      /* harmony import */


      var _angular_core__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(
      /*! @angular/core */
      "./node_modules/@angular/core/__ivy_ngcc__/fesm2015/core.js");
      /* harmony import */


      var _angular_router__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(
      /*! @angular/router */
      "./node_modules/@angular/router/__ivy_ngcc__/fesm2015/router.js");
      /* harmony import */


      var _models__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(
      /*! ../_models */
      "./src/app/_models/index.ts");
      /* harmony import */


      var _services__WEBPACK_IMPORTED_MODULE_3__ = __webpack_require__(
      /*! ../_services */
      "./src/app/_services/index.ts");
      /* harmony import */


      var _angular_common__WEBPACK_IMPORTED_MODULE_4__ = __webpack_require__(
      /*! @angular/common */
      "./node_modules/@angular/common/__ivy_ngcc__/fesm2015/common.js");

      function AlertComponent_div_0_Template(rf, ctx) {
        if (rf & 1) {
          var _r3 = _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵgetCurrentView"]();

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementStart"](0, "div");

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementStart"](1, "a", 1);

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵlistener"]("click", function AlertComponent_div_0_Template_a_click_1_listener() {
            _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵrestoreView"](_r3);

            var alert_r1 = ctx.$implicit;

            var ctx_r2 = _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵnextContext"]();

            return ctx_r2.removeAlert(alert_r1);
          });

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵtext"](2, "\xD7");

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementEnd"]();

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelement"](3, "span", 2);

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementEnd"]();
        }

        if (rf & 2) {
          var alert_r1 = ctx.$implicit;

          var ctx_r0 = _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵnextContext"]();

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵclassMap"](ctx_r0.cssClass(alert_r1));

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵadvance"](3);

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵproperty"]("innerHTML", alert_r1.message, _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵsanitizeHtml"]);
        }
      }

      var AlertComponent = /*#__PURE__*/function () {
        function AlertComponent(router, alertService) {
          _classCallCheck(this, AlertComponent);

          this.router = router;
          this.alertService = alertService;
          this.id = 'default-alert';
          this.fade = true;
          this.alerts = [];
        }

        _createClass(AlertComponent, [{
          key: "ngOnInit",
          value: function ngOnInit() {
            var _this = this;

            // subscribe to new alert notifications
            this.alertSubscription = this.alertService.onAlert(this.id).subscribe(function (alert) {
              // clear alerts when an empty alert is received
              if (!alert.message) {
                // filter out alerts without 'keepAfterRouteChange' flag
                _this.alerts = _this.alerts.filter(function (x) {
                  return x.keepAfterRouteChange;
                }); // remove 'keepAfterRouteChange' flag on the rest

                _this.alerts.forEach(function (x) {
                  return delete x.keepAfterRouteChange;
                });

                return;
              } // add alert to array


              _this.alerts.push(alert); // auto close alert if required


              if (alert.autoClose) {
                setTimeout(function () {
                  return _this.removeAlert(alert);
                }, 3000);
              }
            }); // clear alerts on location change

            this.routeSubscription = this.router.events.subscribe(function (event) {
              if (event instanceof _angular_router__WEBPACK_IMPORTED_MODULE_1__["NavigationStart"]) {
                _this.alertService.clear(_this.id);
              }
            });
          }
        }, {
          key: "ngOnDestroy",
          value: function ngOnDestroy() {
            // unsubscribe to avoid memory leaks
            this.alertSubscription.unsubscribe();
            this.routeSubscription.unsubscribe();
          }
        }, {
          key: "removeAlert",
          value: function removeAlert(alert) {
            var _this2 = this;

            // check if already removed to prevent error on auto close
            if (!this.alerts.includes(alert)) return;

            if (this.fade) {
              // fade out alert
              alert.fade = true; // remove alert after faded out

              setTimeout(function () {
                _this2.alerts = _this2.alerts.filter(function (x) {
                  return x !== alert;
                });
              }, 250);
            } else {
              // remove alert
              this.alerts = this.alerts.filter(function (x) {
                return x !== alert;
              });
            }
          }
        }, {
          key: "cssClass",
          value: function cssClass(alert) {
            var _alertTypeClass;

            if (!alert) return;
            var classes = ['alert', 'alert-dismissable', 'mt-4', 'container'];
            var alertTypeClass = (_alertTypeClass = {}, _defineProperty(_alertTypeClass, _models__WEBPACK_IMPORTED_MODULE_2__["AlertType"].Success, 'alert alert-success'), _defineProperty(_alertTypeClass, _models__WEBPACK_IMPORTED_MODULE_2__["AlertType"].Error, 'alert alert-danger'), _defineProperty(_alertTypeClass, _models__WEBPACK_IMPORTED_MODULE_2__["AlertType"].Info, 'alert alert-info'), _defineProperty(_alertTypeClass, _models__WEBPACK_IMPORTED_MODULE_2__["AlertType"].Warning, 'alert alert-warning'), _alertTypeClass);
            classes.push(alertTypeClass[alert.type]);

            if (alert.fade) {
              classes.push('fade');
            }

            return classes.join(' ');
          }
        }]);

        return AlertComponent;
      }();

      AlertComponent.ɵfac = function AlertComponent_Factory(t) {
        return new (t || AlertComponent)(_angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵdirectiveInject"](_angular_router__WEBPACK_IMPORTED_MODULE_1__["Router"]), _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵdirectiveInject"](_services__WEBPACK_IMPORTED_MODULE_3__["AlertService"]));
      };

      AlertComponent.ɵcmp = _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵdefineComponent"]({
        type: AlertComponent,
        selectors: [["alert"]],
        inputs: {
          id: "id",
          fade: "fade"
        },
        decls: 1,
        vars: 1,
        consts: [[3, "class", 4, "ngFor", "ngForOf"], [1, "close", 3, "click"], [3, "innerHTML"]],
        template: function AlertComponent_Template(rf, ctx) {
          if (rf & 1) {
            _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵtemplate"](0, AlertComponent_div_0_Template, 4, 4, "div", 0);
          }

          if (rf & 2) {
            _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵproperty"]("ngForOf", ctx.alerts);
          }
        },
        directives: [_angular_common__WEBPACK_IMPORTED_MODULE_4__["NgForOf"]],
        encapsulation: 2
      });
      /*@__PURE__*/

      (function () {
        _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵsetClassMetadata"](AlertComponent, [{
          type: _angular_core__WEBPACK_IMPORTED_MODULE_0__["Component"],
          args: [{
            selector: 'alert',
            templateUrl: 'alert.component.html'
          }]
        }], function () {
          return [{
            type: _angular_router__WEBPACK_IMPORTED_MODULE_1__["Router"]
          }, {
            type: _services__WEBPACK_IMPORTED_MODULE_3__["AlertService"]
          }];
        }, {
          id: [{
            type: _angular_core__WEBPACK_IMPORTED_MODULE_0__["Input"]
          }],
          fade: [{
            type: _angular_core__WEBPACK_IMPORTED_MODULE_0__["Input"]
          }]
        });
      })();
      /***/

    },

    /***/
    "./src/app/_components/index.ts":
    /*!**************************************!*\
      !*** ./src/app/_components/index.ts ***!
      \**************************************/

    /*! exports provided: AlertComponent */

    /***/
    function srcApp_componentsIndexTs(module, __webpack_exports__, __webpack_require__) {
      "use strict";

      __webpack_require__.r(__webpack_exports__);
      /* harmony import */


      var _alert_component__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(
      /*! ./alert.component */
      "./src/app/_components/alert.component.ts");
      /* harmony reexport (safe) */


      __webpack_require__.d(__webpack_exports__, "AlertComponent", function () {
        return _alert_component__WEBPACK_IMPORTED_MODULE_0__["AlertComponent"];
      });
      /***/

    },

    /***/
    "./src/app/_helpers/auth.guard.ts":
    /*!****************************************!*\
      !*** ./src/app/_helpers/auth.guard.ts ***!
      \****************************************/

    /*! exports provided: AuthGuard */

    /***/
    function srcApp_helpersAuthGuardTs(module, __webpack_exports__, __webpack_require__) {
      "use strict";

      __webpack_require__.r(__webpack_exports__);
      /* harmony export (binding) */


      __webpack_require__.d(__webpack_exports__, "AuthGuard", function () {
        return AuthGuard;
      });
      /* harmony import */


      var _angular_core__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(
      /*! @angular/core */
      "./node_modules/@angular/core/__ivy_ngcc__/fesm2015/core.js");
      /* harmony import */


      var _angular_router__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(
      /*! @angular/router */
      "./node_modules/@angular/router/__ivy_ngcc__/fesm2015/router.js");
      /* harmony import */


      var _services__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(
      /*! ../_services */
      "./src/app/_services/index.ts");

      var AuthGuard = /*#__PURE__*/function () {
        function AuthGuard(router, accountService) {
          _classCallCheck(this, AuthGuard);

          this.router = router;
          this.accountService = accountService;
        }

        _createClass(AuthGuard, [{
          key: "canActivate",
          value: function canActivate(route, state) {
            var user = this.accountService.userValue;

            if (user) {
              // authorised so return true
              return true;
            } // not logged in so redirect to login page with the return url


            this.router.navigate(['/account/login'], {
              queryParams: {
                returnUrl: state.url
              }
            });
            return false;
          }
        }]);

        return AuthGuard;
      }();

      AuthGuard.ɵfac = function AuthGuard_Factory(t) {
        return new (t || AuthGuard)(_angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵinject"](_angular_router__WEBPACK_IMPORTED_MODULE_1__["Router"]), _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵinject"](_services__WEBPACK_IMPORTED_MODULE_2__["AccountService"]));
      };

      AuthGuard.ɵprov = _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵdefineInjectable"]({
        token: AuthGuard,
        factory: AuthGuard.ɵfac,
        providedIn: 'root'
      });
      /*@__PURE__*/

      (function () {
        _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵsetClassMetadata"](AuthGuard, [{
          type: _angular_core__WEBPACK_IMPORTED_MODULE_0__["Injectable"],
          args: [{
            providedIn: 'root'
          }]
        }], function () {
          return [{
            type: _angular_router__WEBPACK_IMPORTED_MODULE_1__["Router"]
          }, {
            type: _services__WEBPACK_IMPORTED_MODULE_2__["AccountService"]
          }];
        }, null);
      })();
      /***/

    },

    /***/
    "./src/app/_helpers/error.interceptor.ts":
    /*!***********************************************!*\
      !*** ./src/app/_helpers/error.interceptor.ts ***!
      \***********************************************/

    /*! exports provided: ErrorInterceptor */

    /***/
    function srcApp_helpersErrorInterceptorTs(module, __webpack_exports__, __webpack_require__) {
      "use strict";

      __webpack_require__.r(__webpack_exports__);
      /* harmony export (binding) */


      __webpack_require__.d(__webpack_exports__, "ErrorInterceptor", function () {
        return ErrorInterceptor;
      });
      /* harmony import */


      var _angular_core__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(
      /*! @angular/core */
      "./node_modules/@angular/core/__ivy_ngcc__/fesm2015/core.js");
      /* harmony import */


      var rxjs__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(
      /*! rxjs */
      "./node_modules/rxjs/_esm2015/index.js");
      /* harmony import */


      var rxjs_operators__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(
      /*! rxjs/operators */
      "./node_modules/rxjs/_esm2015/operators/index.js");
      /* harmony import */


      var _services__WEBPACK_IMPORTED_MODULE_3__ = __webpack_require__(
      /*! ../_services */
      "./src/app/_services/index.ts");

      var ErrorInterceptor = /*#__PURE__*/function () {
        function ErrorInterceptor(accountService) {
          _classCallCheck(this, ErrorInterceptor);

          this.accountService = accountService;
        }

        _createClass(ErrorInterceptor, [{
          key: "intercept",
          value: function intercept(request, next) {
            var _this3 = this;

            return next.handle(request).pipe(Object(rxjs_operators__WEBPACK_IMPORTED_MODULE_2__["catchError"])(function (err) {
              var _a;

              if ([401, 403].includes(err.status) && _this3.accountService.userValue) {
                // auto logout if 401 or 403 response returned from api
                _this3.accountService.logout();
              }

              var error = ((_a = err.error) === null || _a === void 0 ? void 0 : _a.message) || err.statusText;
              console.error(err);
              return Object(rxjs__WEBPACK_IMPORTED_MODULE_1__["throwError"])(error);
            }));
          }
        }]);

        return ErrorInterceptor;
      }();

      ErrorInterceptor.ɵfac = function ErrorInterceptor_Factory(t) {
        return new (t || ErrorInterceptor)(_angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵinject"](_services__WEBPACK_IMPORTED_MODULE_3__["AccountService"]));
      };

      ErrorInterceptor.ɵprov = _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵdefineInjectable"]({
        token: ErrorInterceptor,
        factory: ErrorInterceptor.ɵfac
      });
      /*@__PURE__*/

      (function () {
        _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵsetClassMetadata"](ErrorInterceptor, [{
          type: _angular_core__WEBPACK_IMPORTED_MODULE_0__["Injectable"]
        }], function () {
          return [{
            type: _services__WEBPACK_IMPORTED_MODULE_3__["AccountService"]
          }];
        }, null);
      })();
      /***/

    },

    /***/
    "./src/app/_helpers/fake-backend.ts":
    /*!******************************************!*\
      !*** ./src/app/_helpers/fake-backend.ts ***!
      \******************************************/

    /*! exports provided: FakeBackendInterceptor, fakeBackendProvider */

    /***/
    function srcApp_helpersFakeBackendTs(module, __webpack_exports__, __webpack_require__) {
      "use strict";

      __webpack_require__.r(__webpack_exports__);
      /* harmony export (binding) */


      __webpack_require__.d(__webpack_exports__, "FakeBackendInterceptor", function () {
        return FakeBackendInterceptor;
      });
      /* harmony export (binding) */


      __webpack_require__.d(__webpack_exports__, "fakeBackendProvider", function () {
        return fakeBackendProvider;
      });
      /* harmony import */


      var _angular_core__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(
      /*! @angular/core */
      "./node_modules/@angular/core/__ivy_ngcc__/fesm2015/core.js");
      /* harmony import */


      var _angular_common_http__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(
      /*! @angular/common/http */
      "./node_modules/@angular/common/__ivy_ngcc__/fesm2015/http.js");
      /* harmony import */


      var rxjs__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(
      /*! rxjs */
      "./node_modules/rxjs/_esm2015/index.js");
      /* harmony import */


      var rxjs_operators__WEBPACK_IMPORTED_MODULE_3__ = __webpack_require__(
      /*! rxjs/operators */
      "./node_modules/rxjs/_esm2015/operators/index.js"); // array in local storage for registered users


      var usersKey = 'Prontogram';
      var users = JSON.parse(localStorage.getItem(usersKey)) || [];

      var FakeBackendInterceptor = /*#__PURE__*/function () {
        function FakeBackendInterceptor() {
          _classCallCheck(this, FakeBackendInterceptor);
        }

        _createClass(FakeBackendInterceptor, [{
          key: "intercept",
          value: function intercept(request, next) {
            var url = request.url,
                method = request.method,
                headers = request.headers,
                body = request.body;
            return handleRoute();

            function handleRoute() {
              switch (true) {
                case url.endsWith('/users/authenticate') && method === 'POST':
                  return authenticate();

                case url.endsWith('/users/register') && method === 'POST':
                  return register();

                case url.endsWith('/users') && method === 'GET':
                  return getUsers();

                case url.match(/\/users\/\d+$/) && method === 'GET':
                  return getUserById();

                case url.match(/\/users\/\d+$/) && method === 'PUT':
                  return updateUser();

                case url.match(/\/users\/\d+$/) && method === 'DELETE':
                  return deleteUser();

                default:
                  // pass through any requests not handled above
                  return next.handle(request);
              }
            } // route functions


            function authenticate() {
              var username = body.username,
                  password = body.password;
              var user = users.find(function (x) {
                return x.username === username && x.password === password;
              });
              if (!user) return error('Username or password is incorrect');
              return ok(Object.assign(Object.assign({}, basicDetails(user)), {
                token: 'fake-jwt-token'
              }));
            }

            function register() {
              var user = body;

              if (users.find(function (x) {
                return x.username === user.username;
              })) {
                return error('Username "' + user.username + '" is already taken');
              }

              user.id = users.length ? Math.max.apply(Math, _toConsumableArray(users.map(function (x) {
                return x.id;
              }))) + 1 : 1;
              users.push(user);
              localStorage.setItem(usersKey, JSON.stringify(users));
              return ok();
            }

            function getUsers() {
              if (!isLoggedIn()) return unauthorized();
              return ok(users.map(function (x) {
                return basicDetails(x);
              }));
            }

            function getUserById() {
              if (!isLoggedIn()) return unauthorized();
              var user = users.find(function (x) {
                return x.id === idFromUrl();
              });
              return ok(basicDetails(user));
            }

            function updateUser() {
              if (!isLoggedIn()) return unauthorized();
              var params = body;
              var user = users.find(function (x) {
                return x.id === idFromUrl();
              }); // only update password if entered

              if (!params.password) {
                delete params.password;
              } // update and save user


              Object.assign(user, params);
              localStorage.setItem(usersKey, JSON.stringify(users));
              return ok();
            }

            function deleteUser() {
              if (!isLoggedIn()) return unauthorized();
              users = users.filter(function (x) {
                return x.id !== idFromUrl();
              });
              localStorage.setItem(usersKey, JSON.stringify(users));
              return ok();
            } // helper functions


            function ok(body) {
              return Object(rxjs__WEBPACK_IMPORTED_MODULE_2__["of"])(new _angular_common_http__WEBPACK_IMPORTED_MODULE_1__["HttpResponse"]({
                status: 200,
                body: body
              })).pipe(Object(rxjs_operators__WEBPACK_IMPORTED_MODULE_3__["delay"])(500)); // delay observable to simulate server api call
            }

            function error(message) {
              return Object(rxjs__WEBPACK_IMPORTED_MODULE_2__["throwError"])({
                error: {
                  message: message
                }
              }).pipe(Object(rxjs_operators__WEBPACK_IMPORTED_MODULE_3__["materialize"])(), Object(rxjs_operators__WEBPACK_IMPORTED_MODULE_3__["delay"])(500), Object(rxjs_operators__WEBPACK_IMPORTED_MODULE_3__["dematerialize"])()); // call materialize and dematerialize to ensure delay even if an error is thrown;
            }

            function unauthorized() {
              return Object(rxjs__WEBPACK_IMPORTED_MODULE_2__["throwError"])({
                status: 401,
                error: {
                  message: 'Unauthorized'
                }
              }).pipe(Object(rxjs_operators__WEBPACK_IMPORTED_MODULE_3__["materialize"])(), Object(rxjs_operators__WEBPACK_IMPORTED_MODULE_3__["delay"])(500), Object(rxjs_operators__WEBPACK_IMPORTED_MODULE_3__["dematerialize"])());
            }

            function basicDetails(user) {
              var id = user.id,
                  username = user.username,
                  nome = user.nome,
                  cognome = user.cognome;
              return {
                id: id,
                username: username,
                nome: nome,
                cognome: cognome
              };
            }

            function isLoggedIn() {
              return headers.get('Authorization') === 'Bearer fake-jwt-token';
            }

            function idFromUrl() {
              var urlParts = url.split('/');
              return parseInt(urlParts[urlParts.length - 1]);
            }
          }
        }]);

        return FakeBackendInterceptor;
      }();

      FakeBackendInterceptor.ɵfac = function FakeBackendInterceptor_Factory(t) {
        return new (t || FakeBackendInterceptor)();
      };

      FakeBackendInterceptor.ɵprov = _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵdefineInjectable"]({
        token: FakeBackendInterceptor,
        factory: FakeBackendInterceptor.ɵfac
      });
      /*@__PURE__*/

      (function () {
        _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵsetClassMetadata"](FakeBackendInterceptor, [{
          type: _angular_core__WEBPACK_IMPORTED_MODULE_0__["Injectable"]
        }], null, null);
      })();

      var fakeBackendProvider = {
        // use fake backend in place of Http service for backend-less development
        provide: _angular_common_http__WEBPACK_IMPORTED_MODULE_1__["HTTP_INTERCEPTORS"],
        useClass: FakeBackendInterceptor,
        multi: true
      };
      /***/
    },

    /***/
    "./src/app/_helpers/index.ts":
    /*!***********************************!*\
      !*** ./src/app/_helpers/index.ts ***!
      \***********************************/

    /*! exports provided: AuthGuard, ErrorInterceptor, JwtInterceptor, FakeBackendInterceptor, fakeBackendProvider */

    /***/
    function srcApp_helpersIndexTs(module, __webpack_exports__, __webpack_require__) {
      "use strict";

      __webpack_require__.r(__webpack_exports__);
      /* harmony import */


      var _auth_guard__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(
      /*! ./auth.guard */
      "./src/app/_helpers/auth.guard.ts");
      /* harmony reexport (safe) */


      __webpack_require__.d(__webpack_exports__, "AuthGuard", function () {
        return _auth_guard__WEBPACK_IMPORTED_MODULE_0__["AuthGuard"];
      });
      /* harmony import */


      var _error_interceptor__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(
      /*! ./error.interceptor */
      "./src/app/_helpers/error.interceptor.ts");
      /* harmony reexport (safe) */


      __webpack_require__.d(__webpack_exports__, "ErrorInterceptor", function () {
        return _error_interceptor__WEBPACK_IMPORTED_MODULE_1__["ErrorInterceptor"];
      });
      /* harmony import */


      var _jwt_interceptor__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(
      /*! ./jwt.interceptor */
      "./src/app/_helpers/jwt.interceptor.ts");
      /* harmony reexport (safe) */


      __webpack_require__.d(__webpack_exports__, "JwtInterceptor", function () {
        return _jwt_interceptor__WEBPACK_IMPORTED_MODULE_2__["JwtInterceptor"];
      });
      /* harmony import */


      var _fake_backend__WEBPACK_IMPORTED_MODULE_3__ = __webpack_require__(
      /*! ./fake-backend */
      "./src/app/_helpers/fake-backend.ts");
      /* harmony reexport (safe) */


      __webpack_require__.d(__webpack_exports__, "FakeBackendInterceptor", function () {
        return _fake_backend__WEBPACK_IMPORTED_MODULE_3__["FakeBackendInterceptor"];
      });
      /* harmony reexport (safe) */


      __webpack_require__.d(__webpack_exports__, "fakeBackendProvider", function () {
        return _fake_backend__WEBPACK_IMPORTED_MODULE_3__["fakeBackendProvider"];
      });
      /***/

    },

    /***/
    "./src/app/_helpers/jwt.interceptor.ts":
    /*!*********************************************!*\
      !*** ./src/app/_helpers/jwt.interceptor.ts ***!
      \*********************************************/

    /*! exports provided: JwtInterceptor */

    /***/
    function srcApp_helpersJwtInterceptorTs(module, __webpack_exports__, __webpack_require__) {
      "use strict";

      __webpack_require__.r(__webpack_exports__);
      /* harmony export (binding) */


      __webpack_require__.d(__webpack_exports__, "JwtInterceptor", function () {
        return JwtInterceptor;
      });
      /* harmony import */


      var _angular_core__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(
      /*! @angular/core */
      "./node_modules/@angular/core/__ivy_ngcc__/fesm2015/core.js");
      /* harmony import */


      var _environments_environment__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(
      /*! ../../environments/environment */
      "./src/environments/environment.ts");
      /* harmony import */


      var _services__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(
      /*! ../_services */
      "./src/app/_services/index.ts");

      var JwtInterceptor = /*#__PURE__*/function () {
        function JwtInterceptor(accountService) {
          _classCallCheck(this, JwtInterceptor);

          this.accountService = accountService;
        }

        _createClass(JwtInterceptor, [{
          key: "intercept",
          value: function intercept(request, next) {
            // add auth header with jwt if user is logged in and request is to the api url
            var user = this.accountService.userValue;
            var isLoggedIn = user && user.token;
            var isApiUrl = request.url.startsWith(_environments_environment__WEBPACK_IMPORTED_MODULE_1__["environment"].apiUrl);

            if (isLoggedIn && isApiUrl) {
              request = request.clone({
                setHeaders: {
                  Authorization: "Bearer ".concat(user.token)
                }
              });
            }

            return next.handle(request);
          }
        }]);

        return JwtInterceptor;
      }();

      JwtInterceptor.ɵfac = function JwtInterceptor_Factory(t) {
        return new (t || JwtInterceptor)(_angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵinject"](_services__WEBPACK_IMPORTED_MODULE_2__["AccountService"]));
      };

      JwtInterceptor.ɵprov = _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵdefineInjectable"]({
        token: JwtInterceptor,
        factory: JwtInterceptor.ɵfac
      });
      /*@__PURE__*/

      (function () {
        _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵsetClassMetadata"](JwtInterceptor, [{
          type: _angular_core__WEBPACK_IMPORTED_MODULE_0__["Injectable"]
        }], function () {
          return [{
            type: _services__WEBPACK_IMPORTED_MODULE_2__["AccountService"]
          }];
        }, null);
      })();
      /***/

    },

    /***/
    "./src/app/_models/airport.ts":
    /*!************************************!*\
      !*** ./src/app/_models/airport.ts ***!
      \************************************/

    /*! exports provided: Airport */

    /***/
    function srcApp_modelsAirportTs(module, __webpack_exports__, __webpack_require__) {
      "use strict";

      __webpack_require__.r(__webpack_exports__);
      /* harmony export (binding) */


      __webpack_require__.d(__webpack_exports__, "Airport", function () {
        return Airport;
      });

      var Airport = function Airport() {
        _classCallCheck(this, Airport);
      };
      /***/

    },

    /***/
    "./src/app/_models/alert.ts":
    /*!**********************************!*\
      !*** ./src/app/_models/alert.ts ***!
      \**********************************/

    /*! exports provided: Alert, AlertType */

    /***/
    function srcApp_modelsAlertTs(module, __webpack_exports__, __webpack_require__) {
      "use strict";

      __webpack_require__.r(__webpack_exports__);
      /* harmony export (binding) */


      __webpack_require__.d(__webpack_exports__, "Alert", function () {
        return Alert;
      });
      /* harmony export (binding) */


      __webpack_require__.d(__webpack_exports__, "AlertType", function () {
        return AlertType;
      });

      var Alert = function Alert(init) {
        _classCallCheck(this, Alert);

        Object.assign(this, init);
      };

      var AlertType;

      (function (AlertType) {
        AlertType[AlertType["Success"] = 0] = "Success";
        AlertType[AlertType["Error"] = 1] = "Error";
        AlertType[AlertType["Info"] = 2] = "Info";
        AlertType[AlertType["Warning"] = 3] = "Warning";
      })(AlertType || (AlertType = {}));
      /***/

    },

    /***/
    "./src/app/_models/flight.ts":
    /*!***********************************!*\
      !*** ./src/app/_models/flight.ts ***!
      \***********************************/

    /*! exports provided: Flight */

    /***/
    function srcApp_modelsFlightTs(module, __webpack_exports__, __webpack_require__) {
      "use strict";

      __webpack_require__.r(__webpack_exports__);
      /* harmony export (binding) */


      __webpack_require__.d(__webpack_exports__, "Flight", function () {
        return Flight;
      });

      var Flight = function Flight() {
        _classCallCheck(this, Flight);
      };
      /***/

    },

    /***/
    "./src/app/_models/index.ts":
    /*!**********************************!*\
      !*** ./src/app/_models/index.ts ***!
      \**********************************/

    /*! exports provided: Alert, AlertType, User, Notification, Subscription, Flight, Airport */

    /***/
    function srcApp_modelsIndexTs(module, __webpack_exports__, __webpack_require__) {
      "use strict";

      __webpack_require__.r(__webpack_exports__);
      /* harmony import */


      var _alert__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(
      /*! ./alert */
      "./src/app/_models/alert.ts");
      /* harmony reexport (safe) */


      __webpack_require__.d(__webpack_exports__, "Alert", function () {
        return _alert__WEBPACK_IMPORTED_MODULE_0__["Alert"];
      });
      /* harmony reexport (safe) */


      __webpack_require__.d(__webpack_exports__, "AlertType", function () {
        return _alert__WEBPACK_IMPORTED_MODULE_0__["AlertType"];
      });
      /* harmony import */


      var _user__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(
      /*! ./user */
      "./src/app/_models/user.ts");
      /* harmony reexport (safe) */


      __webpack_require__.d(__webpack_exports__, "User", function () {
        return _user__WEBPACK_IMPORTED_MODULE_1__["User"];
      });
      /* harmony import */


      var _notification__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(
      /*! ./notification */
      "./src/app/_models/notification.ts");
      /* harmony reexport (safe) */


      __webpack_require__.d(__webpack_exports__, "Notification", function () {
        return _notification__WEBPACK_IMPORTED_MODULE_2__["Notification"];
      });
      /* harmony import */


      var _subscription__WEBPACK_IMPORTED_MODULE_3__ = __webpack_require__(
      /*! ./subscription */
      "./src/app/_models/subscription.ts");
      /* harmony reexport (safe) */


      __webpack_require__.d(__webpack_exports__, "Subscription", function () {
        return _subscription__WEBPACK_IMPORTED_MODULE_3__["Subscription"];
      });
      /* harmony import */


      var _flight__WEBPACK_IMPORTED_MODULE_4__ = __webpack_require__(
      /*! ./flight */
      "./src/app/_models/flight.ts");
      /* harmony reexport (safe) */


      __webpack_require__.d(__webpack_exports__, "Flight", function () {
        return _flight__WEBPACK_IMPORTED_MODULE_4__["Flight"];
      });
      /* harmony import */


      var _airport__WEBPACK_IMPORTED_MODULE_5__ = __webpack_require__(
      /*! ./airport */
      "./src/app/_models/airport.ts");
      /* harmony reexport (safe) */


      __webpack_require__.d(__webpack_exports__, "Airport", function () {
        return _airport__WEBPACK_IMPORTED_MODULE_5__["Airport"];
      });
      /***/

    },

    /***/
    "./src/app/_models/notification.ts":
    /*!*****************************************!*\
      !*** ./src/app/_models/notification.ts ***!
      \*****************************************/

    /*! exports provided: Notification */

    /***/
    function srcApp_modelsNotificationTs(module, __webpack_exports__, __webpack_require__) {
      "use strict";

      __webpack_require__.r(__webpack_exports__);
      /* harmony export (binding) */


      __webpack_require__.d(__webpack_exports__, "Notification", function () {
        return Notification;
      });

      var Notification = function Notification() {
        _classCallCheck(this, Notification);
      };
      /***/

    },

    /***/
    "./src/app/_models/subscription.ts":
    /*!*****************************************!*\
      !*** ./src/app/_models/subscription.ts ***!
      \*****************************************/

    /*! exports provided: Subscription */

    /***/
    function srcApp_modelsSubscriptionTs(module, __webpack_exports__, __webpack_require__) {
      "use strict";

      __webpack_require__.r(__webpack_exports__);
      /* harmony export (binding) */


      __webpack_require__.d(__webpack_exports__, "Subscription", function () {
        return Subscription;
      });

      var Subscription = function Subscription() {
        _classCallCheck(this, Subscription);
      };
      /***/

    },

    /***/
    "./src/app/_models/user.ts":
    /*!*********************************!*\
      !*** ./src/app/_models/user.ts ***!
      \*********************************/

    /*! exports provided: User */

    /***/
    function srcApp_modelsUserTs(module, __webpack_exports__, __webpack_require__) {
      "use strict";

      __webpack_require__.r(__webpack_exports__);
      /* harmony export (binding) */


      __webpack_require__.d(__webpack_exports__, "User", function () {
        return User;
      });

      var User = function User() {
        _classCallCheck(this, User);
      };
      /***/

    },

    /***/
    "./src/app/_services/account.service.ts":
    /*!**********************************************!*\
      !*** ./src/app/_services/account.service.ts ***!
      \**********************************************/

    /*! exports provided: AccountService */

    /***/
    function srcApp_servicesAccountServiceTs(module, __webpack_exports__, __webpack_require__) {
      "use strict";

      __webpack_require__.r(__webpack_exports__);
      /* harmony export (binding) */


      __webpack_require__.d(__webpack_exports__, "AccountService", function () {
        return AccountService;
      });
      /* harmony import */


      var _angular_core__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(
      /*! @angular/core */
      "./node_modules/@angular/core/__ivy_ngcc__/fesm2015/core.js");
      /* harmony import */


      var _angular_router__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(
      /*! @angular/router */
      "./node_modules/@angular/router/__ivy_ngcc__/fesm2015/router.js");
      /* harmony import */


      var _angular_common_http__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(
      /*! @angular/common/http */
      "./node_modules/@angular/common/__ivy_ngcc__/fesm2015/http.js");
      /* harmony import */


      var rxjs__WEBPACK_IMPORTED_MODULE_3__ = __webpack_require__(
      /*! rxjs */
      "./node_modules/rxjs/_esm2015/index.js");
      /* harmony import */


      var rxjs_operators__WEBPACK_IMPORTED_MODULE_4__ = __webpack_require__(
      /*! rxjs/operators */
      "./node_modules/rxjs/_esm2015/operators/index.js");
      /* harmony import */


      var _environments_environment__WEBPACK_IMPORTED_MODULE_5__ = __webpack_require__(
      /*! ../../environments/environment */
      "./src/environments/environment.ts");

      var AccountService = /*#__PURE__*/function () {
        function AccountService(router, http) {
          _classCallCheck(this, AccountService);

          this.router = router;
          this.http = http;
          this.userSubject = new rxjs__WEBPACK_IMPORTED_MODULE_3__["BehaviorSubject"](JSON.parse(localStorage.getItem('user')));
          this.user = this.userSubject.asObservable();
        }

        _createClass(AccountService, [{
          key: "userValue",
          get: function get() {
            return this.userSubject.value;
          }
        }, {
          key: "isLoggedIn",
          value: function isLoggedIn() {
            return this.header.get('auth-token') === this.userValue.token;
          }
        }, {
          key: "login",
          value: function login(username, password) {
            var _this4 = this;

            return this.http.post("".concat(_environments_environment__WEBPACK_IMPORTED_MODULE_5__["environment"].apiUrl, "/auth/login"), {
              username: username,
              password: password
            }).pipe(Object(rxjs_operators__WEBPACK_IMPORTED_MODULE_4__["map"])(function (user) {
              _this4.userSubject.next(user);

              _this4.header = new _angular_common_http__WEBPACK_IMPORTED_MODULE_2__["HttpHeaders"]().set("auth-token", _this4.userSubject.value.token); // store user details and jwt token in local storage to keep user logged in between page refreshes

              localStorage.setItem('user', JSON.stringify(user));
              return user;
            }));
          }
        }, {
          key: "logout",
          value: function logout() {
            this.userSubject.next(null);
            this.router.navigate(['/account/login']);
          }
        }, {
          key: "register",
          value: function register(user) {
            return this.http.post("".concat(_environments_environment__WEBPACK_IMPORTED_MODULE_5__["environment"].apiUrl, "/auth/register"), user);
          }
        }, {
          key: "createUser",
          value: function createUser(user) {
            return this.http.post("".concat(_environments_environment__WEBPACK_IMPORTED_MODULE_5__["environment"].apiUrl, "/user/new"), user, {
              headers: this.getheader()
            });
          }
        }, {
          key: "getAll",
          value: function getAll() {
            return this.http.get("".concat(_environments_environment__WEBPACK_IMPORTED_MODULE_5__["environment"].apiUrl, "/user/all"), {
              headers: this.getheader()
            });
          }
        }, {
          key: "getById",
          value: function getById(id) {
            return this.http.get("".concat(_environments_environment__WEBPACK_IMPORTED_MODULE_5__["environment"].apiUrl, "/user/").concat(id), {
              headers: this.getheader()
            });
          }
        }, {
          key: "update",
          value: function update(id, params) {
            var _this5 = this;

            return this.http.put("".concat(_environments_environment__WEBPACK_IMPORTED_MODULE_5__["environment"].apiUrl, "/user/").concat(id), params, {
              headers: this.getheader()
            }).pipe(Object(rxjs_operators__WEBPACK_IMPORTED_MODULE_4__["map"])(function (x) {
              // update stored user if the logged in user updated their own record
              if (id == _this5.userValue._id) {
                // update local storage
                var user = Object.assign(Object.assign({}, _this5.userValue), params);
                localStorage.setItem('user', JSON.stringify(user)); // publish updated user to subscribers

                _this5.userSubject.next(user);
              }

              return x;
            }));
          }
        }, {
          key: "delete",
          value: function _delete(id) {
            var _this6 = this;

            return this.http["delete"]("".concat(_environments_environment__WEBPACK_IMPORTED_MODULE_5__["environment"].apiUrl, "/user/").concat(id), {
              headers: this.getheader()
            }).pipe(Object(rxjs_operators__WEBPACK_IMPORTED_MODULE_4__["map"])(function (x) {
              // auto logout if the logged in user deleted their own record
              if (id == _this6.userValue._id) {
                _this6.logout();
              }

              return x;
            }));
          }
        }, {
          key: "getheader",
          value: function getheader() {
            return this.header = new _angular_common_http__WEBPACK_IMPORTED_MODULE_2__["HttpHeaders"]().set("auth-token", this.userSubject.value.token);
          }
        }]);

        return AccountService;
      }();

      AccountService.ɵfac = function AccountService_Factory(t) {
        return new (t || AccountService)(_angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵinject"](_angular_router__WEBPACK_IMPORTED_MODULE_1__["Router"]), _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵinject"](_angular_common_http__WEBPACK_IMPORTED_MODULE_2__["HttpClient"]));
      };

      AccountService.ɵprov = _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵdefineInjectable"]({
        token: AccountService,
        factory: AccountService.ɵfac,
        providedIn: 'root'
      });
      /*@__PURE__*/

      (function () {
        _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵsetClassMetadata"](AccountService, [{
          type: _angular_core__WEBPACK_IMPORTED_MODULE_0__["Injectable"],
          args: [{
            providedIn: 'root'
          }]
        }], function () {
          return [{
            type: _angular_router__WEBPACK_IMPORTED_MODULE_1__["Router"]
          }, {
            type: _angular_common_http__WEBPACK_IMPORTED_MODULE_2__["HttpClient"]
          }];
        }, null);
      })();
      /***/

    },

    /***/
    "./src/app/_services/alert.service.ts":
    /*!********************************************!*\
      !*** ./src/app/_services/alert.service.ts ***!
      \********************************************/

    /*! exports provided: AlertService */

    /***/
    function srcApp_servicesAlertServiceTs(module, __webpack_exports__, __webpack_require__) {
      "use strict";

      __webpack_require__.r(__webpack_exports__);
      /* harmony export (binding) */


      __webpack_require__.d(__webpack_exports__, "AlertService", function () {
        return AlertService;
      });
      /* harmony import */


      var _angular_core__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(
      /*! @angular/core */
      "./node_modules/@angular/core/__ivy_ngcc__/fesm2015/core.js");
      /* harmony import */


      var rxjs__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(
      /*! rxjs */
      "./node_modules/rxjs/_esm2015/index.js");
      /* harmony import */


      var rxjs_operators__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(
      /*! rxjs/operators */
      "./node_modules/rxjs/_esm2015/operators/index.js");
      /* harmony import */


      var _models__WEBPACK_IMPORTED_MODULE_3__ = __webpack_require__(
      /*! ../_models */
      "./src/app/_models/index.ts");

      var AlertService = /*#__PURE__*/function () {
        function AlertService() {
          _classCallCheck(this, AlertService);

          this.subject = new rxjs__WEBPACK_IMPORTED_MODULE_1__["Subject"]();
          this.defaultId = 'default-alert';
        } // enable subscribing to alerts observable


        _createClass(AlertService, [{
          key: "onAlert",
          value: function onAlert() {
            var id = arguments.length > 0 && arguments[0] !== undefined ? arguments[0] : this.defaultId;
            return this.subject.asObservable().pipe(Object(rxjs_operators__WEBPACK_IMPORTED_MODULE_2__["filter"])(function (x) {
              return x && x.id === id;
            }));
          } // convenience methods

        }, {
          key: "success",
          value: function success(message, options) {
            this.alert(new _models__WEBPACK_IMPORTED_MODULE_3__["Alert"](Object.assign(Object.assign({}, options), {
              type: _models__WEBPACK_IMPORTED_MODULE_3__["AlertType"].Success,
              message: message
            })));
          }
        }, {
          key: "error",
          value: function error(message, options) {
            this.alert(new _models__WEBPACK_IMPORTED_MODULE_3__["Alert"](Object.assign(Object.assign({}, options), {
              type: _models__WEBPACK_IMPORTED_MODULE_3__["AlertType"].Error,
              message: message
            })));
          }
        }, {
          key: "info",
          value: function info(message, options) {
            this.alert(new _models__WEBPACK_IMPORTED_MODULE_3__["Alert"](Object.assign(Object.assign({}, options), {
              type: _models__WEBPACK_IMPORTED_MODULE_3__["AlertType"].Info,
              message: message
            })));
          }
        }, {
          key: "warn",
          value: function warn(message, options) {
            this.alert(new _models__WEBPACK_IMPORTED_MODULE_3__["Alert"](Object.assign(Object.assign({}, options), {
              type: _models__WEBPACK_IMPORTED_MODULE_3__["AlertType"].Warning,
              message: message
            })));
          } // main alert method    

        }, {
          key: "alert",
          value: function alert(_alert) {
            _alert.id = _alert.id || this.defaultId;
            this.subject.next(_alert);
          } // clear alerts

        }, {
          key: "clear",
          value: function clear() {
            var id = arguments.length > 0 && arguments[0] !== undefined ? arguments[0] : this.defaultId;
            this.subject.next(new _models__WEBPACK_IMPORTED_MODULE_3__["Alert"]({
              id: id
            }));
          }
        }]);

        return AlertService;
      }();

      AlertService.ɵfac = function AlertService_Factory(t) {
        return new (t || AlertService)();
      };

      AlertService.ɵprov = _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵdefineInjectable"]({
        token: AlertService,
        factory: AlertService.ɵfac,
        providedIn: 'root'
      });
      /*@__PURE__*/

      (function () {
        _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵsetClassMetadata"](AlertService, [{
          type: _angular_core__WEBPACK_IMPORTED_MODULE_0__["Injectable"],
          args: [{
            providedIn: 'root'
          }]
        }], null, null);
      })();
      /***/

    },

    /***/
    "./src/app/_services/index.ts":
    /*!************************************!*\
      !*** ./src/app/_services/index.ts ***!
      \************************************/

    /*! exports provided: AccountService, NotificationService, AlertService */

    /***/
    function srcApp_servicesIndexTs(module, __webpack_exports__, __webpack_require__) {
      "use strict";

      __webpack_require__.r(__webpack_exports__);
      /* harmony import */


      var _account_service__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(
      /*! ./account.service */
      "./src/app/_services/account.service.ts");
      /* harmony reexport (safe) */


      __webpack_require__.d(__webpack_exports__, "AccountService", function () {
        return _account_service__WEBPACK_IMPORTED_MODULE_0__["AccountService"];
      });
      /* harmony import */


      var _notification_service__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(
      /*! ./notification.service */
      "./src/app/_services/notification.service.ts");
      /* harmony reexport (safe) */


      __webpack_require__.d(__webpack_exports__, "NotificationService", function () {
        return _notification_service__WEBPACK_IMPORTED_MODULE_1__["NotificationService"];
      });
      /* harmony import */


      var _alert_service__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(
      /*! ./alert.service */
      "./src/app/_services/alert.service.ts");
      /* harmony reexport (safe) */


      __webpack_require__.d(__webpack_exports__, "AlertService", function () {
        return _alert_service__WEBPACK_IMPORTED_MODULE_2__["AlertService"];
      });
      /***/

    },

    /***/
    "./src/app/_services/notification.service.ts":
    /*!***************************************************!*\
      !*** ./src/app/_services/notification.service.ts ***!
      \***************************************************/

    /*! exports provided: NotificationService */

    /***/
    function srcApp_servicesNotificationServiceTs(module, __webpack_exports__, __webpack_require__) {
      "use strict";

      __webpack_require__.r(__webpack_exports__);
      /* harmony export (binding) */


      __webpack_require__.d(__webpack_exports__, "NotificationService", function () {
        return NotificationService;
      });
      /* harmony import */


      var _angular_core__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(
      /*! @angular/core */
      "./node_modules/@angular/core/__ivy_ngcc__/fesm2015/core.js");
      /* harmony import */


      var _angular_common_http__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(
      /*! @angular/common/http */
      "./node_modules/@angular/common/__ivy_ngcc__/fesm2015/http.js");
      /* harmony import */


      var rxjs__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(
      /*! rxjs */
      "./node_modules/rxjs/_esm2015/index.js");
      /* harmony import */


      var rxjs_operators__WEBPACK_IMPORTED_MODULE_3__ = __webpack_require__(
      /*! rxjs/operators */
      "./node_modules/rxjs/_esm2015/operators/index.js");
      /* harmony import */


      var _environments_environment__WEBPACK_IMPORTED_MODULE_4__ = __webpack_require__(
      /*! ../../environments/environment */
      "./src/environments/environment.ts");
      /* harmony import */


      var _models__WEBPACK_IMPORTED_MODULE_5__ = __webpack_require__(
      /*! ../_models */
      "./src/app/_models/index.ts");

      var NotificationService = /*#__PURE__*/function () {
        function NotificationService(http) {
          _classCallCheck(this, NotificationService);

          this.http = http;
          this.notificationSubject = new rxjs__WEBPACK_IMPORTED_MODULE_2__["BehaviorSubject"](JSON.parse(localStorage.getItem('notification')));
          this.notification = this.notificationSubject.asObservable();
        }

        _createClass(NotificationService, [{
          key: "notificationValue",
          get: function get() {
            return this.notificationSubject.value;
          }
        }, {
          key: "createNotification",
          value: function createNotification(notification) {
            return this.http.post("".concat(_environments_environment__WEBPACK_IMPORTED_MODULE_4__["environment"].apiUrl, "/notification/new"), notification);
          }
        }, {
          key: "getAll",
          value: function getAll(username) {
            return this.http.get("".concat(_environments_environment__WEBPACK_IMPORTED_MODULE_4__["environment"].apiUrl, "/notification/all/").concat(username));
          }
        }, {
          key: "getById",
          value: function getById(id) {
            return this.http.get("".concat(_environments_environment__WEBPACK_IMPORTED_MODULE_4__["environment"].apiUrl, "/notification/findOne/").concat(id));
          }
        }, {
          key: "update",
          value: function update(id, params) {
            return this.http.put("".concat(_environments_environment__WEBPACK_IMPORTED_MODULE_4__["environment"].apiUrl, "/notification/").concat(id), params);
          }
        }, {
          key: "delete",
          value: function _delete(id) {
            return this.http["delete"]("".concat(_environments_environment__WEBPACK_IMPORTED_MODULE_4__["environment"].apiUrl, "/notification/").concat(id)).pipe(Object(rxjs_operators__WEBPACK_IMPORTED_MODULE_3__["map"])(function (x) {
              return x;
            }));
          }
        }, {
          key: "sendSubscriptionToTheServer",
          value: function sendSubscriptionToTheServer(subscription, user) {
            var sub = new _models__WEBPACK_IMPORTED_MODULE_5__["Subscription"]();
            sub.subscription = subscription;
            sub.username = user.username;
            console.log(sub);
            return this.http.post("".concat(_environments_environment__WEBPACK_IMPORTED_MODULE_4__["environment"].apiUrl, "/subscription/new"), sub);
          }
        }, {
          key: "unsubscribeToNotification",
          value: function unsubscribeToNotification(subscription) {
            return this.http["delete"]("".concat(_environments_environment__WEBPACK_IMPORTED_MODULE_4__["environment"].apiUrl, "/subscription/").concat(subscription.toJSON()));
          }
        }, {
          key: "send",
          value: function send() {
            return this.http.post("".concat(_environments_environment__WEBPACK_IMPORTED_MODULE_4__["environment"].apiUrl, "/notification/news"), null);
          }
        }]);

        return NotificationService;
      }();

      NotificationService.ɵfac = function NotificationService_Factory(t) {
        return new (t || NotificationService)(_angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵinject"](_angular_common_http__WEBPACK_IMPORTED_MODULE_1__["HttpClient"]));
      };

      NotificationService.ɵprov = _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵdefineInjectable"]({
        token: NotificationService,
        factory: NotificationService.ɵfac,
        providedIn: 'root'
      });
      /*@__PURE__*/

      (function () {
        _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵsetClassMetadata"](NotificationService, [{
          type: _angular_core__WEBPACK_IMPORTED_MODULE_0__["Injectable"],
          args: [{
            providedIn: 'root'
          }]
        }], function () {
          return [{
            type: _angular_common_http__WEBPACK_IMPORTED_MODULE_1__["HttpClient"]
          }];
        }, null);
      })();
      /***/

    },

    /***/
    "./src/app/app-routing.module.ts":
    /*!***************************************!*\
      !*** ./src/app/app-routing.module.ts ***!
      \***************************************/

    /*! exports provided: AppRoutingModule */

    /***/
    function srcAppAppRoutingModuleTs(module, __webpack_exports__, __webpack_require__) {
      "use strict";

      __webpack_require__.r(__webpack_exports__);
      /* harmony export (binding) */


      __webpack_require__.d(__webpack_exports__, "AppRoutingModule", function () {
        return AppRoutingModule;
      });
      /* harmony import */


      var _angular_core__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(
      /*! @angular/core */
      "./node_modules/@angular/core/__ivy_ngcc__/fesm2015/core.js");
      /* harmony import */


      var _angular_router__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(
      /*! @angular/router */
      "./node_modules/@angular/router/__ivy_ngcc__/fesm2015/router.js");
      /* harmony import */


      var _home__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(
      /*! ./home */
      "./src/app/home/index.ts");
      /* harmony import */


      var _notification__WEBPACK_IMPORTED_MODULE_3__ = __webpack_require__(
      /*! ./notification */
      "./src/app/notification/index.ts");
      /* harmony import */


      var _helpers__WEBPACK_IMPORTED_MODULE_4__ = __webpack_require__(
      /*! ./_helpers */
      "./src/app/_helpers/index.ts");

      var accountModule = function accountModule() {
        return __webpack_require__.e(
        /*! import() | account-account-module */
        "account-account-module").then(__webpack_require__.bind(null,
        /*! ./account/account.module */
        "./src/app/account/account.module.ts")).then(function (x) {
          return x.AccountModule;
        });
      };

      var usersModule = function usersModule() {
        return __webpack_require__.e(
        /*! import() | users-users-module */
        "users-users-module").then(__webpack_require__.bind(null,
        /*! ./users/users.module */
        "./src/app/users/users.module.ts")).then(function (x) {
          return x.UsersModule;
        });
      };

      var routes = [{
        path: '',
        component: _home__WEBPACK_IMPORTED_MODULE_2__["HomeComponent"],
        canActivate: [_helpers__WEBPACK_IMPORTED_MODULE_4__["AuthGuard"]]
      }, {
        path: 'users',
        loadChildren: usersModule,
        canActivate: [_helpers__WEBPACK_IMPORTED_MODULE_4__["AuthGuard"]]
      }, {
        path: 'account',
        loadChildren: accountModule
      }, {
        path: 'notification',
        component: _notification__WEBPACK_IMPORTED_MODULE_3__["NotificationComponent"],
        canActivate: [_helpers__WEBPACK_IMPORTED_MODULE_4__["AuthGuard"]]
      }, // otherwise redirect to home
      {
        path: '**',
        redirectTo: ''
      }];

      var AppRoutingModule = function AppRoutingModule() {
        _classCallCheck(this, AppRoutingModule);
      };

      AppRoutingModule.ɵmod = _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵdefineNgModule"]({
        type: AppRoutingModule
      });
      AppRoutingModule.ɵinj = _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵdefineInjector"]({
        factory: function AppRoutingModule_Factory(t) {
          return new (t || AppRoutingModule)();
        },
        imports: [[_angular_router__WEBPACK_IMPORTED_MODULE_1__["RouterModule"].forRoot(routes)], _angular_router__WEBPACK_IMPORTED_MODULE_1__["RouterModule"]]
      });

      (function () {
        (typeof ngJitMode === "undefined" || ngJitMode) && _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵsetNgModuleScope"](AppRoutingModule, {
          imports: [_angular_router__WEBPACK_IMPORTED_MODULE_1__["RouterModule"]],
          exports: [_angular_router__WEBPACK_IMPORTED_MODULE_1__["RouterModule"]]
        });
      })();
      /*@__PURE__*/


      (function () {
        _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵsetClassMetadata"](AppRoutingModule, [{
          type: _angular_core__WEBPACK_IMPORTED_MODULE_0__["NgModule"],
          args: [{
            imports: [_angular_router__WEBPACK_IMPORTED_MODULE_1__["RouterModule"].forRoot(routes)],
            exports: [_angular_router__WEBPACK_IMPORTED_MODULE_1__["RouterModule"]]
          }]
        }], null, null);
      })();
      /***/

    },

    /***/
    "./src/app/app.component.ts":
    /*!**********************************!*\
      !*** ./src/app/app.component.ts ***!
      \**********************************/

    /*! exports provided: AppComponent */

    /***/
    function srcAppAppComponentTs(module, __webpack_exports__, __webpack_require__) {
      "use strict";

      __webpack_require__.r(__webpack_exports__);
      /* harmony export (binding) */


      __webpack_require__.d(__webpack_exports__, "AppComponent", function () {
        return AppComponent;
      });
      /* harmony import */


      var _angular_core__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(
      /*! @angular/core */
      "./node_modules/@angular/core/__ivy_ngcc__/fesm2015/core.js");
      /* harmony import */


      var _services__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(
      /*! ./_services */
      "./src/app/_services/index.ts");
      /* harmony import */


      var _angular_service_worker__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(
      /*! @angular/service-worker */
      "./node_modules/@angular/service-worker/__ivy_ngcc__/fesm2015/service-worker.js");
      /* harmony import */


      var rxjs_operators__WEBPACK_IMPORTED_MODULE_3__ = __webpack_require__(
      /*! rxjs/operators */
      "./node_modules/rxjs/_esm2015/operators/index.js");
      /* harmony import */


      var _angular_common__WEBPACK_IMPORTED_MODULE_4__ = __webpack_require__(
      /*! @angular/common */
      "./node_modules/@angular/common/__ivy_ngcc__/fesm2015/common.js");
      /* harmony import */


      var _components_alert_component__WEBPACK_IMPORTED_MODULE_5__ = __webpack_require__(
      /*! ./_components/alert.component */
      "./src/app/_components/alert.component.ts");
      /* harmony import */


      var _angular_router__WEBPACK_IMPORTED_MODULE_6__ = __webpack_require__(
      /*! @angular/router */
      "./node_modules/@angular/router/__ivy_ngcc__/fesm2015/router.js");

      var _c0 = function _c0() {
        return {
          exact: true
        };
      };

      function AppComponent_nav_0_Template(rf, ctx) {
        if (rf & 1) {
          var _r2 = _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵgetCurrentView"]();

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementStart"](0, "nav", 2);

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementStart"](1, "div", 3);

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementStart"](2, "a", 4);

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵtext"](3, "Home");

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementEnd"]();

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementStart"](4, "a", 5);

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵtext"](5, "Gestione Utente");

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementEnd"]();

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementStart"](6, "a", 6);

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵtext"](7, "Notifiche");

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementEnd"]();

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementStart"](8, "a", 7);

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵlistener"]("click", function AppComponent_nav_0_Template_a_click_8_listener() {
            _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵrestoreView"](_r2);

            var ctx_r1 = _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵnextContext"]();

            return ctx_r1.logout();
          });

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵtext"](9, "Logout");

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementEnd"]();

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementEnd"]();

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementEnd"]();
        }

        if (rf & 2) {
          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵadvance"](2);

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵproperty"]("routerLinkActiveOptions", _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵpureFunction0"](1, _c0));
        }
      }

      var _c1 = function _c1(a0) {
        return {
          "bg-light": a0
        };
      };

      var AppComponent = /*#__PURE__*/function () {
        function AppComponent(accountService, notificationService, swUpdate, swPush) {
          var _this7 = this;

          _classCallCheck(this, AppComponent);

          this.accountService = accountService;
          this.notificationService = notificationService;
          this.swUpdate = swUpdate;
          this.swPush = swPush;
          this.VAPID_PUBLIC_KEY = "BA161ZnkX9G6CwYOZifUyGpOxslxcANly0PfMtti7y1rDO9NZlPNI1yepdaTodQXX0gVHqXHVApmArL1MUNsBoM";
          this.accountService.user.subscribe(function (x) {
            return _this7.user = x;
          });
          this.notificationService.notification.subscribe(function (x) {
            return _this7.notification = x;
          });
          this.pushSubscription();
        }

        _createClass(AppComponent, [{
          key: "ngOnInit",
          value: function ngOnInit() {
            if (this.swUpdate.isEnabled) {
              this.swUpdate.available.subscribe(function () {
                if (confirm("New version available. Load New Version?")) {
                  window.location.reload();
                }
              });
            }
          }
        }, {
          key: "pushSubscription",
          value: function pushSubscription() {
            var _this8 = this;

            if (this.swPush.isEnabled) {
              this.swPush.requestSubscription({
                serverPublicKey: this.VAPID_PUBLIC_KEY
              }).then(function (sub) {
                _this8.notificationService.sendSubscriptionToTheServer(sub, _this8.user).subscribe(function (x) {
                  return console.log(x);
                }, function (err) {
                  return console.log(err);
                });
              })["catch"](function (err) {
                return console.error("Could not subscribe to notifications", err);
              });
            }
          }
        }, {
          key: "logout",
          value: function logout() {
            this.accountService.logout();
            this.unsubscribeNotifications();
          }
        }, {
          key: "unsubscribeNotifications",
          value: function unsubscribeNotifications() {
            var _this9 = this;

            this.swPush.subscription.pipe(Object(rxjs_operators__WEBPACK_IMPORTED_MODULE_3__["take"])(1)).subscribe(function (subscriptionValue) {
              if (subscriptionValue) {
                _this9.notificationService.unsubscribeToNotification(subscriptionValue).subscribe(function (res) {
                  // Unsubscribe current client (browser)
                  subscriptionValue.unsubscribe().then(function (success) {
                    console.log('[App] Unsubscription successful', success);
                  })["catch"](function (err) {
                    console.log('[App] Unsubscription failed', err);
                  });
                }, function (err) {
                  console.log('[App] Delete subscription request failed', err);
                });
              } else {
                console.log("Prima di fare unsubscribe devi fare subscribe!");
              }
            });
          }
        }]);

        return AppComponent;
      }();

      AppComponent.ɵfac = function AppComponent_Factory(t) {
        return new (t || AppComponent)(_angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵdirectiveInject"](_services__WEBPACK_IMPORTED_MODULE_1__["AccountService"]), _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵdirectiveInject"](_services__WEBPACK_IMPORTED_MODULE_1__["NotificationService"]), _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵdirectiveInject"](_angular_service_worker__WEBPACK_IMPORTED_MODULE_2__["SwUpdate"]), _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵdirectiveInject"](_angular_service_worker__WEBPACK_IMPORTED_MODULE_2__["SwPush"]));
      };

      AppComponent.ɵcmp = _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵdefineComponent"]({
        type: AppComponent,
        selectors: [["app"]],
        decls: 4,
        vars: 4,
        consts: [["class", "navbar navbar-expand navbar-dark bg-dark", 4, "ngIf"], [1, "app-container", 3, "ngClass"], [1, "navbar", "navbar-expand", "navbar-dark", "bg-dark"], [1, "navbar-nav"], ["routerLink", "/", "routerLinkActive", "active", 1, "nav-item", "nav-link", 3, "routerLinkActiveOptions"], ["routerLink", "/users", "routerLinkActive", "active", 1, "nav-item", "nav-link"], ["routerLink", "/notification", "routerLinkActive", "active", 1, "nav-item", "nav-link"], [1, "nav-item", "nav-link", 3, "click"]],
        template: function AppComponent_Template(rf, ctx) {
          if (rf & 1) {
            _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵtemplate"](0, AppComponent_nav_0_Template, 10, 2, "nav", 0);

            _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementStart"](1, "div", 1);

            _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelement"](2, "alert");

            _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelement"](3, "router-outlet");

            _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementEnd"]();
          }

          if (rf & 2) {
            _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵproperty"]("ngIf", ctx.user);

            _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵadvance"](1);

            _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵproperty"]("ngClass", _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵpureFunction1"](2, _c1, ctx.user));
          }
        },
        directives: [_angular_common__WEBPACK_IMPORTED_MODULE_4__["NgIf"], _angular_common__WEBPACK_IMPORTED_MODULE_4__["NgClass"], _components_alert_component__WEBPACK_IMPORTED_MODULE_5__["AlertComponent"], _angular_router__WEBPACK_IMPORTED_MODULE_6__["RouterOutlet"], _angular_router__WEBPACK_IMPORTED_MODULE_6__["RouterLinkWithHref"], _angular_router__WEBPACK_IMPORTED_MODULE_6__["RouterLinkActive"]],
        encapsulation: 2
      });
      /*@__PURE__*/

      (function () {
        _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵsetClassMetadata"](AppComponent, [{
          type: _angular_core__WEBPACK_IMPORTED_MODULE_0__["Component"],
          args: [{
            selector: 'app',
            templateUrl: 'app.component.html'
          }]
        }], function () {
          return [{
            type: _services__WEBPACK_IMPORTED_MODULE_1__["AccountService"]
          }, {
            type: _services__WEBPACK_IMPORTED_MODULE_1__["NotificationService"]
          }, {
            type: _angular_service_worker__WEBPACK_IMPORTED_MODULE_2__["SwUpdate"]
          }, {
            type: _angular_service_worker__WEBPACK_IMPORTED_MODULE_2__["SwPush"]
          }];
        }, null);
      })();
      /***/

    },

    /***/
    "./src/app/app.module.ts":
    /*!*******************************!*\
      !*** ./src/app/app.module.ts ***!
      \*******************************/

    /*! exports provided: AppModule */

    /***/
    function srcAppAppModuleTs(module, __webpack_exports__, __webpack_require__) {
      "use strict";

      __webpack_require__.r(__webpack_exports__);
      /* harmony export (binding) */


      __webpack_require__.d(__webpack_exports__, "AppModule", function () {
        return AppModule;
      });
      /* harmony import */


      var _angular_core__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(
      /*! @angular/core */
      "./node_modules/@angular/core/__ivy_ngcc__/fesm2015/core.js");
      /* harmony import */


      var _angular_platform_browser__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(
      /*! @angular/platform-browser */
      "./node_modules/@angular/platform-browser/__ivy_ngcc__/fesm2015/platform-browser.js");
      /* harmony import */


      var _angular_forms__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(
      /*! @angular/forms */
      "./node_modules/@angular/forms/__ivy_ngcc__/fesm2015/forms.js");
      /* harmony import */


      var _angular_common_http__WEBPACK_IMPORTED_MODULE_3__ = __webpack_require__(
      /*! @angular/common/http */
      "./node_modules/@angular/common/__ivy_ngcc__/fesm2015/http.js");
      /* harmony import */


      var _app_routing_module__WEBPACK_IMPORTED_MODULE_4__ = __webpack_require__(
      /*! ./app-routing.module */
      "./src/app/app-routing.module.ts");
      /* harmony import */


      var _app_component__WEBPACK_IMPORTED_MODULE_5__ = __webpack_require__(
      /*! ./app.component */
      "./src/app/app.component.ts");
      /* harmony import */


      var _components__WEBPACK_IMPORTED_MODULE_6__ = __webpack_require__(
      /*! ./_components */
      "./src/app/_components/index.ts");
      /* harmony import */


      var _notification__WEBPACK_IMPORTED_MODULE_7__ = __webpack_require__(
      /*! ./notification */
      "./src/app/notification/index.ts");
      /* harmony import */


      var _angular_service_worker__WEBPACK_IMPORTED_MODULE_8__ = __webpack_require__(
      /*! @angular/service-worker */
      "./node_modules/@angular/service-worker/__ivy_ngcc__/fesm2015/service-worker.js");
      /* harmony import */


      var _environments_environment__WEBPACK_IMPORTED_MODULE_9__ = __webpack_require__(
      /*! @environments/environment */
      "./src/environments/environment.ts");
      /* harmony import */


      var _app_services__WEBPACK_IMPORTED_MODULE_10__ = __webpack_require__(
      /*! ../app/_services */
      "./src/app/_services/index.ts");
      /* harmony import */


      var _angular_material_card__WEBPACK_IMPORTED_MODULE_11__ = __webpack_require__(
      /*! @angular/material/card */
      "./node_modules/@angular/material/__ivy_ngcc__/fesm2015/card.js");

      ;

      var AppModule = function AppModule() {
        _classCallCheck(this, AppModule);
      };

      AppModule.ɵmod = _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵdefineNgModule"]({
        type: AppModule,
        bootstrap: [_app_component__WEBPACK_IMPORTED_MODULE_5__["AppComponent"]]
      });
      AppModule.ɵinj = _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵdefineInjector"]({
        factory: function AppModule_Factory(t) {
          return new (t || AppModule)();
        },
        providers: [_app_services__WEBPACK_IMPORTED_MODULE_10__["AccountService"], _app_services__WEBPACK_IMPORTED_MODULE_10__["NotificationService"]],
        imports: [[_angular_platform_browser__WEBPACK_IMPORTED_MODULE_1__["BrowserModule"], _angular_forms__WEBPACK_IMPORTED_MODULE_2__["ReactiveFormsModule"], _angular_common_http__WEBPACK_IMPORTED_MODULE_3__["HttpClientModule"], _app_routing_module__WEBPACK_IMPORTED_MODULE_4__["AppRoutingModule"], _angular_service_worker__WEBPACK_IMPORTED_MODULE_8__["ServiceWorkerModule"].register('ngsw-worker.js', {
          enabled: _environments_environment__WEBPACK_IMPORTED_MODULE_9__["environment"].production
        }), _angular_material_card__WEBPACK_IMPORTED_MODULE_11__["MatCardModule"]]]
      });

      (function () {
        (typeof ngJitMode === "undefined" || ngJitMode) && _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵsetNgModuleScope"](AppModule, {
          declarations: [_app_component__WEBPACK_IMPORTED_MODULE_5__["AppComponent"], _components__WEBPACK_IMPORTED_MODULE_6__["AlertComponent"], _notification__WEBPACK_IMPORTED_MODULE_7__["NotificationComponent"]],
          imports: [_angular_platform_browser__WEBPACK_IMPORTED_MODULE_1__["BrowserModule"], _angular_forms__WEBPACK_IMPORTED_MODULE_2__["ReactiveFormsModule"], _angular_common_http__WEBPACK_IMPORTED_MODULE_3__["HttpClientModule"], _app_routing_module__WEBPACK_IMPORTED_MODULE_4__["AppRoutingModule"], _angular_service_worker__WEBPACK_IMPORTED_MODULE_8__["ServiceWorkerModule"], _angular_material_card__WEBPACK_IMPORTED_MODULE_11__["MatCardModule"]]
        });
      })();
      /*@__PURE__*/


      (function () {
        _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵsetClassMetadata"](AppModule, [{
          type: _angular_core__WEBPACK_IMPORTED_MODULE_0__["NgModule"],
          args: [{
            imports: [_angular_platform_browser__WEBPACK_IMPORTED_MODULE_1__["BrowserModule"], _angular_forms__WEBPACK_IMPORTED_MODULE_2__["ReactiveFormsModule"], _angular_common_http__WEBPACK_IMPORTED_MODULE_3__["HttpClientModule"], _app_routing_module__WEBPACK_IMPORTED_MODULE_4__["AppRoutingModule"], _angular_service_worker__WEBPACK_IMPORTED_MODULE_8__["ServiceWorkerModule"].register('ngsw-worker.js', {
              enabled: _environments_environment__WEBPACK_IMPORTED_MODULE_9__["environment"].production
            }), _angular_material_card__WEBPACK_IMPORTED_MODULE_11__["MatCardModule"]],
            declarations: [_app_component__WEBPACK_IMPORTED_MODULE_5__["AppComponent"], _components__WEBPACK_IMPORTED_MODULE_6__["AlertComponent"], _notification__WEBPACK_IMPORTED_MODULE_7__["NotificationComponent"]],
            providers: [_app_services__WEBPACK_IMPORTED_MODULE_10__["AccountService"], _app_services__WEBPACK_IMPORTED_MODULE_10__["NotificationService"]],
            bootstrap: [_app_component__WEBPACK_IMPORTED_MODULE_5__["AppComponent"]]
          }]
        }], null, null);
      })();

      ;
      /***/
    },

    /***/
    "./src/app/home/home.component.ts":
    /*!****************************************!*\
      !*** ./src/app/home/home.component.ts ***!
      \****************************************/

    /*! exports provided: HomeComponent */

    /***/
    function srcAppHomeHomeComponentTs(module, __webpack_exports__, __webpack_require__) {
      "use strict";

      __webpack_require__.r(__webpack_exports__);
      /* harmony export (binding) */


      __webpack_require__.d(__webpack_exports__, "HomeComponent", function () {
        return HomeComponent;
      });
      /* harmony import */


      var _angular_core__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(
      /*! @angular/core */
      "./node_modules/@angular/core/__ivy_ngcc__/fesm2015/core.js");
      /* harmony import */


      var _app_services__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(
      /*! @app/_services */
      "./src/app/_services/index.ts");

      var HomeComponent = function HomeComponent(accountService) {
        _classCallCheck(this, HomeComponent);

        this.accountService = accountService;
        this.user = this.accountService.userValue;
      };

      HomeComponent.ɵfac = function HomeComponent_Factory(t) {
        return new (t || HomeComponent)(_angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵdirectiveInject"](_app_services__WEBPACK_IMPORTED_MODULE_1__["AccountService"]));
      };

      HomeComponent.ɵcmp = _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵdefineComponent"]({
        type: HomeComponent,
        selectors: [["ng-component"]],
        decls: 4,
        vars: 1,
        consts: [[1, "p-4"], [1, "container"]],
        template: function HomeComponent_Template(rf, ctx) {
          if (rf & 1) {
            _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementStart"](0, "div", 0);

            _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementStart"](1, "div", 1);

            _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementStart"](2, "h1");

            _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵtext"](3);

            _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementEnd"]();

            _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementEnd"]();

            _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementEnd"]();
          }

          if (rf & 2) {
            _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵadvance"](3);

            _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵtextInterpolate1"]("Benvenuto in Prontogram, ", ctx.user.name, "! ");
          }
        },
        encapsulation: 2
      });
      /*@__PURE__*/

      (function () {
        _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵsetClassMetadata"](HomeComponent, [{
          type: _angular_core__WEBPACK_IMPORTED_MODULE_0__["Component"],
          args: [{
            templateUrl: 'home.component.html'
          }]
        }], function () {
          return [{
            type: _app_services__WEBPACK_IMPORTED_MODULE_1__["AccountService"]
          }];
        }, null);
      })();
      /***/

    },

    /***/
    "./src/app/home/index.ts":
    /*!*******************************!*\
      !*** ./src/app/home/index.ts ***!
      \*******************************/

    /*! exports provided: HomeComponent */

    /***/
    function srcAppHomeIndexTs(module, __webpack_exports__, __webpack_require__) {
      "use strict";

      __webpack_require__.r(__webpack_exports__);
      /* harmony import */


      var _home_component__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(
      /*! ./home.component */
      "./src/app/home/home.component.ts");
      /* harmony reexport (safe) */


      __webpack_require__.d(__webpack_exports__, "HomeComponent", function () {
        return _home_component__WEBPACK_IMPORTED_MODULE_0__["HomeComponent"];
      });
      /***/

    },

    /***/
    "./src/app/notification/index.ts":
    /*!***************************************!*\
      !*** ./src/app/notification/index.ts ***!
      \***************************************/

    /*! exports provided: NotificationComponent */

    /***/
    function srcAppNotificationIndexTs(module, __webpack_exports__, __webpack_require__) {
      "use strict";

      __webpack_require__.r(__webpack_exports__);
      /* harmony import */


      var _notification_component__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(
      /*! ./notification.component */
      "./src/app/notification/notification.component.ts");
      /* harmony reexport (safe) */


      __webpack_require__.d(__webpack_exports__, "NotificationComponent", function () {
        return _notification_component__WEBPACK_IMPORTED_MODULE_0__["NotificationComponent"];
      });
      /***/

    },

    /***/
    "./src/app/notification/notification.component.ts":
    /*!********************************************************!*\
      !*** ./src/app/notification/notification.component.ts ***!
      \********************************************************/

    /*! exports provided: NotificationComponent */

    /***/
    function srcAppNotificationNotificationComponentTs(module, __webpack_exports__, __webpack_require__) {
      "use strict";

      __webpack_require__.r(__webpack_exports__);
      /* harmony export (binding) */


      __webpack_require__.d(__webpack_exports__, "NotificationComponent", function () {
        return NotificationComponent;
      });
      /* harmony import */


      var _angular_core__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(
      /*! @angular/core */
      "./node_modules/@angular/core/__ivy_ngcc__/fesm2015/core.js");
      /* harmony import */


      var _models__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(
      /*! ../_models */
      "./src/app/_models/index.ts");
      /* harmony import */


      var _services__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(
      /*! ../_services */
      "./src/app/_services/index.ts");
      /* harmony import */


      var rxjs_operators__WEBPACK_IMPORTED_MODULE_3__ = __webpack_require__(
      /*! rxjs/operators */
      "./node_modules/rxjs/_esm2015/operators/index.js");
      /* harmony import */


      var _angular_service_worker__WEBPACK_IMPORTED_MODULE_4__ = __webpack_require__(
      /*! @angular/service-worker */
      "./node_modules/@angular/service-worker/__ivy_ngcc__/fesm2015/service-worker.js");
      /* harmony import */


      var rxjs__WEBPACK_IMPORTED_MODULE_5__ = __webpack_require__(
      /*! rxjs */
      "./node_modules/rxjs/_esm2015/index.js");
      /* harmony import */


      var _angular_common__WEBPACK_IMPORTED_MODULE_6__ = __webpack_require__(
      /*! @angular/common */
      "./node_modules/@angular/common/__ivy_ngcc__/fesm2015/common.js");
      /* harmony import */


      var _angular_material_card__WEBPACK_IMPORTED_MODULE_7__ = __webpack_require__(
      /*! @angular/material/card */
      "./node_modules/@angular/material/__ivy_ngcc__/fesm2015/card.js");

      function NotificationComponent_div_4_mat_card_subtitle_52_Template(rf, ctx) {
        if (rf & 1) {
          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementStart"](0, "mat-card-subtitle");

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementStart"](1, "b");

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵtext"](2, "Volo di ritorno");

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementEnd"]();

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementStart"](3, "mat-card-content");

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementStart"](4, "table", 4);

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementStart"](5, "thead");

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementStart"](6, "tr");

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementStart"](7, "th", 5);

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵtext"](8, "Codice volo");

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementEnd"]();

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementStart"](9, "th", 6);

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵtext"](10, "Aereoporto di partenza");

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementEnd"]();

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementStart"](11, "th", 6);

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵtext"](12, "Aereoporto di arrivo");

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementEnd"]();

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementStart"](13, "th", 5);

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵtext"](14, "Compagnia aerea");

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementEnd"]();

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementStart"](15, "th", 5);

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵtext"](16, "Prezzo");

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementEnd"]();

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementEnd"]();

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementEnd"]();

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementStart"](17, "tbody");

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementStart"](18, "tr");

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementStart"](19, "td");

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵtext"](20);

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementEnd"]();

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementStart"](21, "td");

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementStart"](22, "div");

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵtext"](23);

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelement"](24, "br");

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵtext"](25);

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelement"](26, "br");

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵtext"](27);

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementEnd"]();

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementEnd"]();

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementStart"](28, "td");

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementStart"](29, "div");

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵtext"](30);

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelement"](31, "br");

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵtext"](32);

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelement"](33, "br");

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵtext"](34);

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementEnd"]();

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementEnd"]();

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementStart"](35, "td");

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵtext"](36);

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementEnd"]();

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementStart"](37, "td");

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵtext"](38);

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementEnd"]();

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementEnd"]();

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementEnd"]();

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementEnd"]();

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementEnd"]();

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementEnd"]();
        }

        if (rf & 2) {
          var notification_r1 = _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵnextContext"]().$implicit;

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵadvance"](20);

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵtextInterpolate"](notification_r1.flyBack.flightCode);

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵadvance"](3);

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵtextInterpolate1"](" Nome: ", notification_r1.flyBack.departure_airport.name, "");

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵadvance"](2);

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵtextInterpolate1"](" Citt\xE0: ", notification_r1.flyBack.departure_airport.cityName, "");

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵadvance"](2);

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵtextInterpolate1"](" Data e ora: ", notification_r1.flyBack.departureDateTime, " ");

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵadvance"](3);

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵtextInterpolate1"](" Nome: ", notification_r1.flyBack.arrival_airport.name, "");

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵadvance"](2);

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵtextInterpolate1"](" Citt\xE0: ", notification_r1.flyBack.arrival_airport.cityName, "");

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵadvance"](2);

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵtextInterpolate1"](" Data e ora: ", notification_r1.flyBack.arrivalDateTime, " ");

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵadvance"](2);

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵtextInterpolate"](notification_r1.flyBack.AirlineName);

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵadvance"](2);

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵtextInterpolate1"]("", notification_r1.flyBack.price, " \u20AC");
        }
      }

      function NotificationComponent_div_4_span_55_Template(rf, ctx) {
        if (rf & 1) {
          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelement"](0, "span", 10);
        }
      }

      function NotificationComponent_div_4_span_56_Template(rf, ctx) {
        if (rf & 1) {
          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementStart"](0, "span");

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵtext"](1, "Elimina");

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementEnd"]();
        }
      }

      function NotificationComponent_div_4_Template(rf, ctx) {
        if (rf & 1) {
          var _r7 = _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵgetCurrentView"]();

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementStart"](0, "div");

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementStart"](1, "mat-card", 3);

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementStart"](2, "mat-card-title");

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵtext"](3, " Notifica volo per ");

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementStart"](4, "b");

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵtext"](5);

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementEnd"]();

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵtext"](6, ", il token dell'offerta da inserire su ");

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementStart"](7, "i");

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵtext"](8, "ACMESky");

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementEnd"]();

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵtext"](9, " \xE8: ");

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementStart"](10, "b");

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵtext"](11);

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementEnd"]();

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementStart"](12, "mat-card-subtitle");

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelement"](13, "br");

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementStart"](14, "b");

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵtext"](15, "Volo di andata");

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementEnd"]();

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementStart"](16, "mat-card-content");

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementStart"](17, "table", 4);

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementStart"](18, "thead");

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementStart"](19, "tr");

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementStart"](20, "th", 5);

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵtext"](21, "Codice volo");

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementEnd"]();

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementStart"](22, "th", 6);

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵtext"](23, "Aereoporto di partenza");

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementEnd"]();

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementStart"](24, "th", 6);

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵtext"](25, "Aereoporto di arrivo");

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementEnd"]();

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementStart"](26, "th", 5);

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵtext"](27, "Compagnia aerea");

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementEnd"]();

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementStart"](28, "th", 5);

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵtext"](29, "Prezzo");

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementEnd"]();

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementEnd"]();

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementEnd"]();

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementStart"](30, "tbody");

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementStart"](31, "tr");

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementStart"](32, "td");

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵtext"](33);

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementEnd"]();

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementStart"](34, "td");

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementStart"](35, "div");

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵtext"](36);

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelement"](37, "br");

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵtext"](38);

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelement"](39, "br");

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵtext"](40);

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementEnd"]();

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementEnd"]();

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementStart"](41, "td");

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementStart"](42, "div");

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵtext"](43);

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelement"](44, "br");

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵtext"](45);

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelement"](46, "br");

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵtext"](47);

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementEnd"]();

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementEnd"]();

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementStart"](48, "td");

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵtext"](49);

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementEnd"]();

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementStart"](50, "td");

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵtext"](51);

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementEnd"]();

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementEnd"]();

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementEnd"]();

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementEnd"]();

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementEnd"]();

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementEnd"]();

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵtemplate"](52, NotificationComponent_div_4_mat_card_subtitle_52_Template, 39, 9, "mat-card-subtitle", 7);

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementEnd"]();

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementStart"](53, "mat-card-actions");

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementStart"](54, "button", 8);

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵlistener"]("click", function NotificationComponent_div_4_Template_button_click_54_listener() {
            _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵrestoreView"](_r7);

            var notification_r1 = ctx.$implicit;

            var ctx_r6 = _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵnextContext"]();

            return ctx_r6.deleteNotification(notification_r1._id);
          });

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵtemplate"](55, NotificationComponent_div_4_span_55_Template, 1, 0, "span", 9);

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵtemplate"](56, NotificationComponent_div_4_span_56_Template, 2, 0, "span", 7);

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementEnd"]();

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementEnd"]();

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementEnd"]();

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementEnd"]();
        }

        if (rf & 2) {
          var notification_r1 = ctx.$implicit;

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵadvance"](5);

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵtextInterpolate"](notification_r1.username);

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵadvance"](6);

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵtextInterpolate"](notification_r1.offerToken);

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵadvance"](22);

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵtextInterpolate"](notification_r1.flyOutBound.flightCode);

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵadvance"](3);

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵtextInterpolate1"](" Nome: ", notification_r1.flyOutBound.departure_airport.name, "");

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵadvance"](2);

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵtextInterpolate1"](" Citt\xE0: ", notification_r1.flyOutBound.departure_airport.cityName, "");

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵadvance"](2);

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵtextInterpolate1"](" Data e ora: ", notification_r1.flyOutBound.departureDateTime, " ");

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵadvance"](3);

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵtextInterpolate1"](" Nome: ", notification_r1.flyOutBound.arrival_airport.name, "");

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵadvance"](2);

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵtextInterpolate1"](" Citt\xE0: ", notification_r1.flyOutBound.arrival_airport.cityName, "");

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵadvance"](2);

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵtextInterpolate1"](" Data e ora: ", notification_r1.flyOutBound.arrivalDateTime, " ");

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵadvance"](2);

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵtextInterpolate"](notification_r1.flyOutBound.AirlineName);

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵadvance"](2);

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵtextInterpolate1"]("", notification_r1.flyOutBound.price, " \u20AC");

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵadvance"](1);

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵproperty"]("ngIf", notification_r1.flyBack);

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵadvance"](3);

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵproperty"]("ngIf", notification_r1.isDeleting);

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵadvance"](1);

          _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵproperty"]("ngIf", !notification_r1.isDeleting);
        }
      }

      var NotificationComponent = /*#__PURE__*/function () {
        function NotificationComponent(swPush, notificationService, accountService) {
          _classCallCheck(this, NotificationComponent);

          this.swPush = swPush;
          this.notificationService = notificationService;
          this.accountService = accountService;
          this.ngUnsubscribe = new rxjs__WEBPACK_IMPORTED_MODULE_5__["Subject"]();
          this.VAPID_PUBLIC_KEY = "BA161ZnkX9G6CwYOZifUyGpOxslxcANly0PfMtti7y1rDO9NZlPNI1yepdaTodQXX0gVHqXHVApmArL1MUNsBoM";
          this.user = this.accountService.userValue;
        }

        _createClass(NotificationComponent, [{
          key: "ngOnInit",
          value: function ngOnInit() {
            var _this10 = this;

            if (navigator.serviceWorker) {
              // First, do a one-off check if there's currently a service worker in control.
              if (navigator.serviceWorker.controller) {
                console.log("This page is currently controlled by: ".concat(navigator.serviceWorker.controller));

                navigator.serviceWorker.controller.onstatechange = function () {
                  console.log('state' + navigator.serviceWorker.controller.state);
                };
              } else {
                //This happens on ctrl+f5(force refresh)
                console.log('This page is not currently controlled by a service worker.');
                navigator.serviceWorker.register('./ngsw-worker.js').then(function (registration) {
                  console.log('Service worker registration succeeded:', registration);
                  window.location.reload();
                }), function (error) {
                  console.log('Service worker registration failed:', error);
                };
              } // Then, register a handler to detect when a new or
              // updated service worker takes control.


              navigator.serviceWorker.oncontrollerchange = function () {
                console.log('This page is now controlled by:', navigator.serviceWorker.controller);
              };
            } else {
              console.log('Service workers are not supported.');
            } //load all notifications


            this.getAllNotifications(); //add new notification to notifications

            this.swPush.messages.pipe(Object(rxjs_operators__WEBPACK_IMPORTED_MODULE_3__["takeUntil"])(this.ngUnsubscribe)).subscribe(function (message) {
              //Create new Notification
              var notification = message['notification'];
              var notify = new _models__WEBPACK_IMPORTED_MODULE_1__["Notification"]();
              notify.flyBack = notification['data']['flyBack'];
              notify.flyOutBound = notification['data']['flyOutBound'];
              notify.offerToken = notification['data']['offerToken'];
              notify.username = notification['data']['username'];
              console.log("Notifica ricevuta ", notify);

              _this10.updateNotificationView();
            }); //notification's actions

            this.swPush.notificationClicks.subscribe(function (_ref) {//window.open(notification.data.url);

              var action = _ref.action,
                  notification = _ref.notification;
            });
          }
        }, {
          key: "deleteNotification",
          value: function deleteNotification(id) {
            var _this11 = this;

            this.notificationService["delete"](id).pipe(Object(rxjs_operators__WEBPACK_IMPORTED_MODULE_3__["first"])()).subscribe(function () {
              return _this11.notifications = _this11.notifications.filter(function (x) {
                return x._id !== id;
              });
            });
          }
        }, {
          key: "getAllNotifications",
          value: function getAllNotifications() {
            var _this12 = this;

            this.notificationService.getAll(this.user.username).subscribe(function (res) {
              _this12.notifications = res;
            }, function (err) {
              console.error(err);
            });
          }
        }, {
          key: "updateNotificationView",
          value: function updateNotificationView() {
            this.getAllNotifications();
          }
        }, {
          key: "ngOnDestroy",
          value: function ngOnDestroy() {
            this.ngUnsubscribe.next();
            this.ngUnsubscribe.complete();
          }
        }]);

        return NotificationComponent;
      }();

      NotificationComponent.ɵfac = function NotificationComponent_Factory(t) {
        return new (t || NotificationComponent)(_angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵdirectiveInject"](_angular_service_worker__WEBPACK_IMPORTED_MODULE_4__["SwPush"]), _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵdirectiveInject"](_services__WEBPACK_IMPORTED_MODULE_2__["NotificationService"]), _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵdirectiveInject"](_services__WEBPACK_IMPORTED_MODULE_2__["AccountService"]));
      };

      NotificationComponent.ɵcmp = _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵdefineComponent"]({
        type: NotificationComponent,
        selectors: [["ng-component"]],
        decls: 5,
        vars: 1,
        consts: [[1, "p-4"], [1, "container"], [4, "ngFor", "ngForOf"], [2, "background-color", "white", "border", "1px solid rgb(42, 42, 43)", "margin-bottom", "5px"], [1, "table", "table-striped"], [2, "width", "10%"], [2, "width", "35%"], [4, "ngIf"], [1, "btn", "btn-sm", "btn-danger", "btn-delete-user", 3, "click"], ["class", "spinner-border spinner-border-sm", 4, "ngIf"], [1, "spinner-border", "spinner-border-sm"]],
        template: function NotificationComponent_Template(rf, ctx) {
          if (rf & 1) {
            _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementStart"](0, "div", 0);

            _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementStart"](1, "div", 1);

            _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementStart"](2, "h1");

            _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵtext"](3, "Notifiche");

            _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementEnd"]();

            _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵtemplate"](4, NotificationComponent_div_4_Template, 57, 14, "div", 2);

            _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementEnd"]();

            _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementEnd"]();
          }

          if (rf & 2) {
            _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵadvance"](4);

            _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵproperty"]("ngForOf", ctx.notifications);
          }
        },
        directives: [_angular_common__WEBPACK_IMPORTED_MODULE_6__["NgForOf"], _angular_material_card__WEBPACK_IMPORTED_MODULE_7__["MatCard"], _angular_material_card__WEBPACK_IMPORTED_MODULE_7__["MatCardTitle"], _angular_material_card__WEBPACK_IMPORTED_MODULE_7__["MatCardSubtitle"], _angular_material_card__WEBPACK_IMPORTED_MODULE_7__["MatCardContent"], _angular_common__WEBPACK_IMPORTED_MODULE_6__["NgIf"], _angular_material_card__WEBPACK_IMPORTED_MODULE_7__["MatCardActions"]],
        encapsulation: 2
      });
      /*@__PURE__*/

      (function () {
        _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵsetClassMetadata"](NotificationComponent, [{
          type: _angular_core__WEBPACK_IMPORTED_MODULE_0__["Component"],
          args: [{
            templateUrl: './notification.component.html'
          }]
        }], function () {
          return [{
            type: _angular_service_worker__WEBPACK_IMPORTED_MODULE_4__["SwPush"]
          }, {
            type: _services__WEBPACK_IMPORTED_MODULE_2__["NotificationService"]
          }, {
            type: _services__WEBPACK_IMPORTED_MODULE_2__["AccountService"]
          }];
        }, null);
      })();
      /***/

    },

    /***/
    "./src/environments/environment.ts":
    /*!*****************************************!*\
      !*** ./src/environments/environment.ts ***!
      \*****************************************/

    /*! exports provided: environment */

    /***/
    function srcEnvironmentsEnvironmentTs(module, __webpack_exports__, __webpack_require__) {
      "use strict";

      __webpack_require__.r(__webpack_exports__);
      /* harmony export (binding) */


      __webpack_require__.d(__webpack_exports__, "environment", function () {
        return environment;
      }); // This file can be replaced during build by using the `fileReplacements` array.
      // `ng build --prod` replaces `environment.ts` with `environment.prod.ts`.
      // The list of file replacements can be found in `angular.json`.


      var environment = {
        production: false,
        apiUrl: 'http://localhost:8000/api'
      };
      /*
       * For easier debugging in development mode, you can import the following file
       * to ignore zone related error stack frames such as `zone.run`, `zoneDelegate.invokeTask`.
       *
       * This import should be commented out in production mode because it will have a negative impact
       * on performance if an error is thrown.
       */
      // import 'zone.js/dist/zone-error';  // Included with Angular CLI.

      /***/
    },

    /***/
    "./src/main.ts":
    /*!*********************!*\
      !*** ./src/main.ts ***!
      \*********************/

    /*! no exports provided */

    /***/
    function srcMainTs(module, __webpack_exports__, __webpack_require__) {
      "use strict";

      __webpack_require__.r(__webpack_exports__);
      /* harmony import */


      var _angular_core__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(
      /*! @angular/core */
      "./node_modules/@angular/core/__ivy_ngcc__/fesm2015/core.js");
      /* harmony import */


      var _environments_environment__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(
      /*! ./environments/environment */
      "./src/environments/environment.ts");
      /* harmony import */


      var _app_app_module__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(
      /*! ./app/app.module */
      "./src/app/app.module.ts");
      /* harmony import */


      var _angular_platform_browser__WEBPACK_IMPORTED_MODULE_3__ = __webpack_require__(
      /*! @angular/platform-browser */
      "./node_modules/@angular/platform-browser/__ivy_ngcc__/fesm2015/platform-browser.js");

      if (_environments_environment__WEBPACK_IMPORTED_MODULE_1__["environment"].production) {
        Object(_angular_core__WEBPACK_IMPORTED_MODULE_0__["enableProdMode"])();
      } //platformBrowserDynamic().bootstrapModule(AppModule)
      //  .catch(err => console.error(err));


      _angular_platform_browser__WEBPACK_IMPORTED_MODULE_3__["platformBrowser"]().bootstrapModule(_app_app_module__WEBPACK_IMPORTED_MODULE_2__["AppModule"]).then(function () {
        if ('serviceWorker' in navigator && _environments_environment__WEBPACK_IMPORTED_MODULE_1__["environment"].production) {
          navigator.serviceWorker.register('ngsw-worker.js');
        }
      })["catch"](function (err) {
        return console.log(err);
      });
      /***/

    },

    /***/
    0:
    /*!***************************!*\
      !*** multi ./src/main.ts ***!
      \***************************/

    /*! no static exports found */

    /***/
    function _(module, exports, __webpack_require__) {
      module.exports = __webpack_require__(
      /*! D:\Repos\ACMEsky\src\prontogram\front-end\src\main.ts */
      "./src/main.ts");
      /***/
    }
  }, [[0, "runtime", "vendor"]]]);
})();
//# sourceMappingURL=main-es5.js.map