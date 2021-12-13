<cfoutput>
	<cfparam name="request.metaTitle" default=""/>
	<cfparam name="request.metaDescription" default=""/>
	<!doctype html>
	<html lang="en">
		<head>
			<meta charset="utf-8">
			<meta name="viewport" content="width=device-width, initial-scale=1">
			<meta name="description" content="#request.metaDescription#">
			<title>cf-simple-mvc · #request.metaTitle#</title>
			<link rel="canonical" href="https://getbootstrap.com/docs/5.1/examples/pricing/">
			<!-- Bootstrap core CSS -->
			<link href="/includes/css/bootstrap.min.css" rel="stylesheet">

			<style>
				body {
					background-image: linear-gradient(180deg, ##eee, ##fff 100px, ##fff);
				}
				.container {
					max-width: 960px;
				}
			</style>
		</head>
		<body>

			<div class="container py-3">
				<header>
					<div class="d-flex flex-column flex-md-row align-items-center pb-3 mb-4 border-bottom">
						<a href="/" class="d-flex align-items-center text-dark text-decoration-none">
							<svg xmlns="http://www.w3.org/2000/svg" width="40" height="32" class="me-2" viewBox="0 0 118 94" role="img"><title>Bootstrap</title><path fill-rule="evenodd" clip-rule="evenodd" d="M24.509 0c-6.733 0-11.715 5.893-11.492 12.284.214 6.14-.064 14.092-2.066 20.577C8.943 39.365 5.547 43.485 0 44.014v5.972c5.547.529 8.943 4.649 10.951 11.153 2.002 6.485 2.28 14.437 2.066 20.577C12.794 88.106 17.776 94 24.51 94H93.5c6.733 0 11.714-5.893 11.491-12.284-.214-6.14.064-14.092 2.066-20.577 2.009-6.504 5.396-10.624 10.943-11.153v-5.972c-5.547-.529-8.934-4.649-10.943-11.153-2.002-6.484-2.28-14.437-2.066-20.577C105.214 5.894 100.233 0 93.5 0H24.508zM80 57.863C80 66.663 73.436 72 62.543 72H44a2 2 0 01-2-2V24a2 2 0 012-2h18.437c9.083 0 15.044 4.92 15.044 12.474 0 5.302-4.01 10.049-9.119 10.88v.277C75.317 46.394 80 51.21 80 57.863zM60.521 28.34H49.948v14.934h8.905c6.884 0 10.68-2.772 10.68-7.727 0-4.643-3.264-7.207-9.012-7.207zM49.948 49.2v16.458H60.91c7.167 0 10.964-2.876 10.964-8.281 0-5.406-3.903-8.178-11.425-8.178H49.948z" fill="currentColor"></path></svg>
							<span class="fs-4">cf-simple-mvc</span>
						</a>

						<nav class="d-inline-flex mt-2 mt-md-0 ms-md-auto">
							<a class="me-3 py-2 text-dark text-decoration-none" href="?event=page.about">About</a>
							<a class="me-3 py-2 text-dark text-decoration-none" href="?event=page.contact">Contact</a>
							<a class="me-3 py-2 text-dark text-decoration-none" href="?event=admin.login">Login</a>
						</nav>
					</div>

					<div class="p-3 pb-md-4 mx-auto text-center">
						<h1 class="display-4 fw-normal">cf-simple-mvc</h1>
						<p class="fs-5 text-muted">Quickly build an effective applicaion.</p>
					</div>
				</header>

				<main>
					<div class="row row-cols-1 row-cols-md-3 mb-3 text-center">
						<!--- output the view content --->
						#request.pageContent#
					</div>
				</main>

				<footer class="pt-4 my-md-5 pt-md-5 border-top">
					<div class="row">
						<div class="col-12 col-md">
							<img class="mb-2" src="https://getbootstrap.com/docs/5.1/assets/brand/bootstrap-logo.svg" alt="" width="24" height="19">
							<small class="d-block mb-3 text-muted">&copy; 2017–2021</small>
						</div>
						<div class="col-6 col-md">
							<h5>Features</h5>
							<ul class="list-unstyled text-small">
								<li class="mb-1"><a class="link-secondary text-decoration-none" href="##">Cool stuff</a></li>
								<li class="mb-1"><a class="link-secondary text-decoration-none" href="##">Another one</a></li>
							</ul>
						</div>
						<div class="col-6 col-md">
							<h5>Resources</h5>
							<ul class="list-unstyled text-small">
								<li class="mb-1"><a class="link-secondary text-decoration-none" href="##">Resource name</a></li>
							</ul>
						</div>
						<div class="col-6 col-md">
							<h5>About</h5>
							<ul class="list-unstyled text-small">
								<li class="mb-1"><a class="link-secondary text-decoration-none" href="##">Team</a></li>
								<li class="mb-1"><a class="link-secondary text-decoration-none" href="##">About Us</a></li>
							</ul>
						</div>
					</div>
				</footer>
			</div>
		</body>
	</html>
</cfoutput>
