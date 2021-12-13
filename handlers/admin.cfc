/**
 * dashboard handler
**/
component{
	/**
	 * Constructor
	 */
	public admin function init() {
		request.layout = 'dashboard';
		userService = new models.user();
		return this;
	}

	public function login( ) {
		request.layout = '';
		request.metaTitle = 'Login';

		if(structKeyExists(form, "submit")){
			cflocation( url="?event=admin.home", addtoken="false" );
		}		
	}

	public function home( ) {
		request.metaTitle = 'Home';
		request.navSelector = 'home';
	}

	public function customers( ) {
		request.metaTitle = 'Customers';
		request.navSelector = 'customers';
	}

}
