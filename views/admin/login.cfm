<cfoutput>
	<!doctype html>
	<html lang="en">
		<head>
			<meta charset="utf-8">
			<meta name="viewport" content="width=device-width, initial-scale=1">
			<meta name="description" content="">
			<title>cf-simple-mvc · login</title>
			<link rel="canonical" href="https://getbootstrap.com/docs/5.1/examples/sign-in/">
			<!-- Bootstrap core CSS -->
			<link href="/includes/css/bootstrap.min.css" rel="stylesheet">

			<style>
				html,
				body {
					height: 100%;
				}

				body {
					display: flex;
					align-items: center;
					padding-top: 40px;
					padding-bottom: 40px;
					background-color: ##f5f5f5;
				}

				.form-signin {
					width: 100%;
					max-width: 330px;
					padding: 15px;
					margin: auto;
				}

				.form-signin .checkbox {
					font-weight: 400;
				}

				.form-signin .form-floating:focus-within {
					z-index: 2;
				}

				.form-signin input[type="email"] {
					margin-bottom: -1px;
					border-bottom-right-radius: 0;
					border-bottom-left-radius: 0;
				}

				.form-signin input[type="password"] {
					margin-bottom: 10px;
					border-top-left-radius: 0;
					border-top-right-radius: 0;
				}
			</style>
		</head>
		<body class="text-center">

			<main class="form-signin">
				<form method="post" action="">
					<img class="mb-4" src="https://getbootstrap.com/docs/5.1/assets/brand/bootstrap-logo.svg" alt="" width="72" height="57">
					<h1 class="h3 mb-3 fw-normal">Please sign in</h1>

					<div class="form-floating">
					<input type="email" class="form-control" id="floatingInput" placeholder="name@example.com">
					<label for="floatingInput">Email address</label>
					</div>
					<div class="form-floating">
					<input type="password" class="form-control" id="floatingPassword" placeholder="Password">
					<label for="floatingPassword">Password</label>
					</div>

					<div class="checkbox mb-3">
					<label>
					<input type="checkbox" value="remember-me"> Remember me
					</label>
					</div>
					<button class="w-100 btn btn-lg btn-primary" type="submit" name="submit">Sign in</button>
					<p class="mt-5 mb-3 text-muted">&copy; 2017–2021</p>
				</form>
			</main>
		</body>
	</html>
</cfoutput>
