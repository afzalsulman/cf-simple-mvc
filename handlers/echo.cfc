/**
 * A basic handler
**/
component{

	/**
	 * Constructor
	 */
	public echo function init() {
		return this;
	}

	public function index( ) {
		request.metaTitle = 'Home';
		request.metaDescription = 'Home page meta description';
	}

}
