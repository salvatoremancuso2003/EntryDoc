<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <!--begin::Head-->
    <head>
        <title>Data entry</title>
        <meta charset="utf-8" />
        <meta name="description" content="The most advanced Bootstrap 5 Admin Theme with 40 unique prebuilt layouts on Themeforest trusted by 100,000 beginners and professionals. Multi-demo, Dark Mode, RTL support and complete React, Angular, Vue, Asp.Net Core, Rails, Spring, Blazor, Django, Express.js, Node.js, Flask, Symfony & Laravel versions. Grab your copy now and get life-time updates for free." />
        <meta name="keywords" content="metronic, bootstrap, bootstrap 5, angular, VueJs, React, Asp.Net Core, Rails, Spring, Blazor, Django, Express.js, Node.js, Flask, Symfony & Laravel starter kits, admin themes, web design, figma, web development, free templates, free admin themes, bootstrap theme, bootstrap template, bootstrap dashboard, bootstrap dak mode, bootstrap button, bootstrap datepicker, bootstrap timepicker, fullcalendar, datatables, flaticon" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <link rel="canonical" href="https://preview.keenthemes.com/metronic8" />
        <link rel="shortcut icon" href="assets/media/logos/favicon.ico" />
        <!--begin::Fonts(mandatory for all pages)-->
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Inter:300,400,500,600,700" />
        <!--end::Fonts-->
        <!--begin::Global Stylesheets Bundle(mandatory for all pages)-->
        <link href="assets/plugins/global/plugins.bundle.css" rel="stylesheet" type="text/css" />
        <link href="assets/css/style.bundle.css" rel="stylesheet" type="text/css" />
        <!--end::Global Stylesheets Bundle-->


        <style>
            .bg-01 {
                background-image: url('assets/media/auth/bg6.jpg');
            }
            

        </style>

    </head>
    <!--end::Head-->
    <!--begin::Body-->
    <body>
        <div class="d-flex flex-column flex-root bg-01" id="kt_app_root">
            <div class="d-flex flex-column flex-center flex-column-fluid">
                <!--begin::Content-->
                <div class="d-flex flex-column flex-center text-center p-10">
                    <!--begin::Wrapper-->
                    <div class="card card-flush" style="box-shadow: rgba(241,241,244,0.3) 6px 2px 16px 0px,rgba(241,241,244,0.3) -6px -2px 16px 0px;" >
                        <div class="card-body ">
                            <!--begin::Logo-->
                            <!--<div class="mb-7">
                                <a href="index.html" class="">
                                    <img alt="Logo" src="assets/media/logos/custom-2.svg" class="h-40px" />
                                </a>
                            </div>-->
                            <!--end::Logo-->
                            <!--begin::Title-->
                            <h1 class="fw-bolder text-gray-900 mb-5">Accedi</h1>
                            <!--end::Title-->
                            <!--begin::Text-->
                            <div class="fw-semibold fs-6 text-gray-500 mb-7">

                            </div>
                            <!--end::Text-->
                            <!--begin::Illustration-->
                            <div class="" style="width: 100%;">
                                <form action="Login" method="POST" id="login_form">
                                    <!-- Email input -->
                                    <div class="row">
                                        <div class="form-group" style="align-content: center">
                                            <input  type="email" id="username" class="form-control" name="username"/>
                                            <label class="form-label" for="username">Username</label>
                                        </div>
                                    </div>
                                    <!-- Password input -->
                                    <div class="row">
                                        <div class="form-group" style="position: relative;">
                                            <input type="password" id="password" class="form-control" name="password"/>
                                            <button id="togglePasswordButton" type="button" style="background: none; border: none; position: absolute; right: 10px; top: 30%; transform: translateY(-50%); font-size: 15px" >
                                                <i id="togglePasswordIcon" class="bi bi-eye-slash-fill"></i>
                                            </button>
                                            <label class="form-label" for="password">Password</label>
                                        </div>
                                    </div>
                                    <script>
                                        let togglePasswordButton = document.getElementById('togglePasswordButton');
                                        let password = document.getElementById('password');
                                        let isPasswordVisible = false;
                                        let togglePasswordIcon = document.getElementById('togglePasswordIcon');

                                        togglePasswordButton.addEventListener('click', function (event) {
                                            event.preventDefault();
                                            isPasswordVisible = !isPasswordVisible;
                                            password.type = isPasswordVisible ? "text" : "password";
                                            togglePasswordIcon.className = isPasswordVisible ? "bi bi-eye-fill" : "bi bi-eye-slash-fill";
                                        });
                                    </script>

                                    <!-- Submit button -->
                                    <button type="submit" class="btn btn-secondary  hover-elevate-up">
                                        Login
                                    </button>

                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>


        <!--end::Root-->
        <!--begin::Javascript-->
        <!--begin::Global Javascript Bundle(mandatory for all pages)-->
        <script src="assets/plugins/global/plugins.bundle.js"></script>
        <script src="assets/js/scripts.bundle.js"></script>
        <!--end::Global Javascript Bundle-->

        <!--begin::Vendors Javascript(used for this page only)-->

        <!--end::Vendors Javascript-->

        <!--begin::Custom Javascript(used for this page only)-->
        <script src="assets/js/widgets.bundle.js"></script>
        <script src="assets/js/custom/widgets.js"></script>
        <script src="assets/js/custom/apps/chat/chat.js"></script>
        <script src="assets/js/custom/utilities/modals/upgrade-plan.js"></script>
        <script src="assets/js/custom/utilities/modals/create-app.js"></script>
        <script src="assets/js/custom/utilities/modals/new-target.js"></script>
        <script src="assets/js/custom/utilities/modals/users-search.js"></script>
        <!--end::Custom Javascript-->
        <!--end::Javascript-->

        <script>
                                            (function () {
                                                'use strict'

                                                var forms = document.querySelectorAll('.needs-validation')

                                                Array.prototype.slice.call(forms)
                                                        .forEach(function (form) {
                                                            form.addEventListener('submit', function (event) {
                                                                if (!form.checkValidity()) {
                                                                    event.preventDefault()
                                                                    event.stopPropagation()
                                                                }

                                                                form.classList.add('was-validated')
                                                            }, false)
                                                        })
                                            })()
        </script>

        <script>
            var defaultThemeMode = "light";
            var them
            eMode;
            if (document.documentElement)
            {
                if (
                        document.documentElement.hasAttribute("data-bs-theme-mode")) {
                    themeMode = document.documentElement.getAttribute("data-bs-theme-mode");
                } else {
                    if (localStorage.getItem("data-bs-theme") !== null) {
                        themeMode = localStorage.getItem("data-bs-theme");
                    } else {
                        themeMode = defaultThemeMode;
                    }
                }
                if (themeMode === "system") {
                    themeMode = window.matchMedia("(prefers-color-scheme: dark)").matches ? "dark" : "light";
                }
                document.documentElement.setAttribute("data-bs-theme", themeMode);
            }
        </script>
    </body>
    <!--end::Body-->
</html>