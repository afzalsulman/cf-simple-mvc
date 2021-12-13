/**
 * A pages handler
**/
component{

	/**
	 * Constructor
	 */
	public page function init() {
		return this;
	}

	public function about( ) {
		request.metaTitle = 'About';
		request.metaDescription = 'About page meta description';
	}

	public function contact( ) {
		request.metaTitle = 'Contact';
		request.metaDescription = 'Contact page meta description';
	}

}
