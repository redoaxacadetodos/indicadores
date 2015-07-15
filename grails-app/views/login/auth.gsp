<html>
<head>
	<meta name='layout' content='publico' lang="es"/>
	<title><g:message code="springSecurity.login.title"/></title>
	<style type='text/css' media='screen'>
	#login {
		margin: 15px 0px;
		padding: 0px;
		text-align: center;
	}

	#login .inner {
		width: 340px;
		padding-bottom: 6px;
		margin: 60px auto;
		text-align: left;
		border: 1px solid #C7C194;
		background-color: #F5F3E1;
	}

	#login .inner .fheader {
		padding: 18px 26px 14px 26px;
		background-color: #C7C194;
		margin: 0px 0 14px 0;
		color: #2e3741;
		font-size: 18px;
		font-weight: 300;
	}

	#login .inner .cssform p {
		clear: left;
		margin: 0;
		padding: 4px 0 3px 0;
		padding-left: 105px;
		margin-bottom: 20px;
		height: 1%;
	}

	#login .inner .cssform input[type='text'] {
		width: 120px;
	}

	#login .inner .cssform label {
		font-weight: bold;
		float: left;
		text-align: right;
		margin-left: -105px;
		width: 110px;
		padding-top: 3px;
		padding-right: 10px;
	}

	#login #remember_me_holder label {
		float: none;
		margin-left: 0;
		text-align: left;
		width: 200px
	}

	#login .inner .login_message {
		padding: 6px 25px 20px 25px;
		color: #c33;
	}

	#login .inner .text_ {
		width: 120px;
	}

	#login .inner .chk {
		height: 12px;
	}
	</style>
</head>

<body>
<nav id="top_navigation">
<div id='login'>
	<div class='inner'>
		<div class='fheader'><g:message code="springSecurity.login.header"/></div>

		<g:if test='${flash.message}'>
			<div class='login_message'>${flash.message}</div>
		</g:if>
		<div class="panel-body">
		<form action='${postUrl}' method='POST' id='loginForm' autocomplete='off'>
			<div class='form-group'>
				<label for='username'><g:message code="springSecurity.login.username.label"/>:</label>
				<input type='text' class='form-control' name='j_username' id='username'/>
			</div>

			<div class='form-group'>
				<label for='password'><g:message code="springSecurity.login.password.label"/>:</label>
				<input type='password' class='form-control' class='text_' name='j_password' id='password'/>
			</div>

			%{--<div class="checkbox" id="remember_me_holder">--}%
				%{--<label>--}%
				%{--<input type='checkbox' name='${rememberMeParameter}' id='remember_me' <g:if test='${hasCookie}'>checked='checked'</g:if>/>--}%
				%{--<g:message code="springSecurity.login.remember.me.label"/>--}%
				%{--</label>--}%
			%{--</div>--}%

				<input class='btn btn-success btn-block' type='submit' id="submit" value='${message(code: "springSecurity.login.button")}'/>
		</form>
		</div>
	</div>
</div>
<script type='text/javascript'>
	<!--
	(function() {
		document.forms['loginForm'].elements['j_username'].focus();
	})();
	// -->
</script>
</nav>
</body>
</html>
