component {

	/**
	 * Constructor
	 */
	user function init() {
		return this;
	}

	public query function qGetLoginUser( required string email, required string password ) {
		var paramsStruct = {};
		var sqlString = "
						SELECT
							u.`id` AS userID,
							u.`name` AS userName,
							u.`email` AS userEmail,
							u.`isActive`,
							u.`emailVerified`,
							ub.`id` AS businessID,
							ub.`name` AS businessName
						FROM
							`user` u
						INNER JOIN
							`userbusiness` ub
						WHERE
							u.`email` = :email
						AND
							u.`password` = :password
						LIMIT 1";

		structAppend( paramsStruct, { email = { value=arguments.email, cfsqltype="varchar" } } );
		structAppend( paramsStruct, { password = { value=arguments.password, cfsqltype="varchar" } } );

		var qResult = queryNew('');
		qResult = queryExecute( sqlString, paramsStruct , { result="qResult" } );
		// update user login date
		if(qResult.recordCount){
			this.qUpdateUserDate(qResult.userID);
		}

		return qResult;
	}

	public void function qUpdateUserDate( required numeric id, string action = 'lastLoginDate' ) {
		var paramsStruct = {};
		var sqlString = "
						UPDATE
							`user`
						SET
							`#action#` = :modifiedDate
						WHERE
							`id` = :id";

		structAppend( paramsStruct, { modifiedDate = { value=createODBCDateTime(now()), cfsqltype="timestamp" } } );
		structAppend( paramsStruct, { id = { value=arguments.id, cfsqltype="integer" } } );

		queryExecute( sqlString, paramsStruct );
	}

	public numeric function qSaveUser( required string name, required string email, required string password ) {
		var paramsStruct = {};
		var sqlString = "
						INSERT INTO
							`user`
							(
								`name`,
								`email`,
								`password`,
								`userGroupID`
							)
						VALUES( :name, :email, :password, :userGroupID )";

		structAppend( paramsStruct, { name = { value=left(arguments.name, 250), cfsqltype="varchar" } } );
		structAppend( paramsStruct, { email = { value=left(arguments.email, 50), cfsqltype="varchar" } } );
		structAppend( paramsStruct, { password = { value=left(arguments.password, 200), cfsqltype="varchar" } } );
		structAppend( paramsStruct, { userGroupID = { value=1, cfsqltype="integer" } } );

		var qResult = {};
		queryExecute( sqlString, paramsStruct , { result="qResult" } );
		return qResult.generatedKey;
	}

	public numeric function qSaveBusiness( required string name, string email, string phone, string address ) {
		var paramsStruct = {};
		var sqlString = "
						INSERT INTO
							`userbusiness`
							(
								`name`,
								`email`,
								`phone`,
								`address`
							)
						VALUES( :name, :address, :phone, :email )";

		structAppend( paramsStruct, { name = { value=left(arguments.name, 250), cfsqltype="varchar" } } );
		structAppend( paramsStruct, { email = { value=left(arguments.email, 50), cfsqltype="varchar", null="#trim(arguments.email) EQ ''#" } } );
		structAppend( paramsStruct, { phone = { value=left(arguments.phone, 40), cfsqltype="varchar", null="#trim(arguments.phone) EQ ''#" } } );
		structAppend( paramsStruct, { address = { value=left(arguments.address, 120), cfsqltype="varchar", null="#trim(arguments.address) EQ ''#" } } );

		var qResult = {};
		queryExecute( sqlString, paramsStruct , { result="qResult" } );
		return qResult.generatedKey;
	}

	public numeric function qSaveUserBusiness( required numeric userID, required numeric businessID ) {
		var paramsStruct = {};
		var sqlString = "
						INSERT INTO
							`userbusinessrelation`
							(
								`userID`,
								`businessID`
							)
						VALUES( :userID, :businessID )";

		structAppend( paramsStruct, { userID = { value=arguments.userID, cfsqltype="integer" } } );
		structAppend( paramsStruct, { businessID = { value=arguments.businessID, cfsqltype="integer" } } );

		var qResult = {};
		queryExecute( sqlString, paramsStruct , { result="qResult" } );
		return qResult.generatedKey;
	}

	// 
	// customer queries
	// 
	// search details
	public query function qCustomerSearch( required string searchText, string maxRows, string stepOffset ) {
		var paramsStruct = {};
		var sqlString = "
						SELECT
							c.id,
							COALESCE(c.name,'') AS name,
							COALESCE(c.email,'') AS email,
							COALESCE(c.phone,'') AS phone
						FROM
							customer c
						INNER JOIN
							userbusiness b ON b.id = c.businessID
						WHERE
							b.id = :businessID
						AND 
							(
								c.name LIKE :name
								OR c.email LIKE :email
								OR c.phone LIKE :phone
								OR c.address LIKE :address
								OR c.notes LIKE :notes
								OR c.tags LIKE :tags
								OR c.city LIKE :city
							)";

		structAppend( paramsStruct, { businessID = { value=request.businessID, cfsqltype="integer" } } );
		structAppend( paramsStruct, { name = { value="%#trim(arguments.searchText)#%", cfsqltype="varchar" } } );
		structAppend( paramsStruct, { email = { value="%#trim(arguments.searchText)#%", cfsqltype="varchar" } } );
		structAppend( paramsStruct, { phone = { value="%#trim(arguments.searchText)#%", cfsqltype="varchar" } } );
		structAppend( paramsStruct, { address = { value="%#trim(arguments.searchText)#%", cfsqltype="varchar" } } );
		structAppend( paramsStruct, { notes = { value="%#trim(arguments.searchText)#%", cfsqltype="varchar" } } );
		structAppend( paramsStruct, { tags = { value="%#trim(arguments.searchText)#%", cfsqltype="varchar" } } );
		structAppend( paramsStruct, { city = { value="%#trim(arguments.searchText)#%", cfsqltype="varchar" } } );

		sqlString = sqlString & " ORDER BY c.id DESC";
		if( isValid("integer", arguments.maxRows) AND arguments.maxRows GTE 0 AND isValid("integer", arguments.stepOffset) AND arguments.stepOffset GTE 0){
			sqlString = sqlString & " LIMIT :limitValue OFFSET :offsetValue";
			structAppend( paramsStruct, { limitValue = { value=arguments.maxRows, cfsqltype="integer" } } );
			structAppend( paramsStruct, { offsetValue = { value=arguments.stepOffset, cfsqltype="integer" } } );
		}

		return queryExecute( sqlString, paramsStruct , { result="qResult" } );
	}
	// save details
	public numeric function qCustomerSave( required string name, string email, string phone, string address, string notes, string tags, string city ) {
		var paramsStruct = {};
		var sqlString = "
						INSERT INTO
							`customer`
						(
							`name`, `email`, `phone`, `address`, `notes`,
							`tags`, `city`, `createdDate`, `businessID`
						)
						VALUES
						(
							:name,:email,:phone,:address,:notes,
							:tags,:city,:createdDate,:businessID
						)";

		structAppend( paramsStruct, { name = { value=left(arguments.name,110), cfsqltype="varchar" } } );
		structAppend( paramsStruct, { email = { value=left(arguments.email,40), cfsqltype="varchar", null="#trim(arguments.email) EQ ''#" } } );
		structAppend( paramsStruct, { phone = { value=left(arguments.phone,25), cfsqltype="varchar", null="#trim(arguments.phone) EQ ''#" } } );
		structAppend( paramsStruct, { address = { value=left(arguments.address,240), cfsqltype="varchar", null="#trim(arguments.address) EQ ''#" } } );
		structAppend( paramsStruct, { notes = { value=left(arguments.notes,110), cfsqltype="varchar", null="#trim(arguments.notes) EQ ''#" } } );
		structAppend( paramsStruct, { tags = { value=left(arguments.tags,110), cfsqltype="varchar", null="#trim(arguments.tags) EQ ''#" } } );
		structAppend( paramsStruct, { city = { value=left(arguments.city,110), cfsqltype="varchar", null="#trim(arguments.city) EQ ''#" } } );
		structAppend( paramsStruct, { createdDate = { value=createODBCDateTime(now()), cfsqltype="timestamp" } } );
		structAppend( paramsStruct, { businessID = { value=request.businessID, cfsqltype="integer" } } );

		var qResult = {};
		queryExecute( sqlString, paramsStruct , { result="qResult" } );
		return qResult.generatedKey;
	}
	// get details
	public query function qCustomerGet( string id, string email, string phone ) {
		var paramsStruct = {};
		var sqlString = "
						SELECT
							c.id,
							c.name,
							c.email,
							c.phone,
							c.address,
							c.city,
							c.notes,
							c.tags,
							DATE_FORMAT(c.createdDate,'%d-%m-%Y') AS createdDate
						FROM
							customer c
						INNER JOIN
							userbusiness b ON b.id = c.businessID
						WHERE
							b.id = :businessID";
		if(isValid('integer', arguments.id)){
			sqlString = sqlString & " AND c.id = :id";
			structAppend( paramsStruct, { id = { value=arguments.id, cfsqltype="integer" } } );
		}
		if(len(trim(arguments.email))){
			sqlString = sqlString & " AND c.email = :email";
			structAppend( paramsStruct, { email = { value=arguments.email, cfsqltype="varchar" } } );
		}
		if(len(trim(arguments.phone))){
			sqlString = sqlString & " AND c.phone = :phone";
			structAppend( paramsStruct, { phone = { value=arguments.phone, cfsqltype="varchar" } } );
		}

		structAppend( paramsStruct, { businessID = { value=request.businessID, cfsqltype="integer" } } );

		return queryExecute( sqlString, paramsStruct , { result="qResult" } );
	}
	// update query
	public numeric function qCustomerUpdate( required numeric id, required string name, string email, string phone, string notes, string tags, string address, string city ) {
		var paramsStruct = {};
		var sqlString = "
						UPDATE customer c
						INNER JOIN
							userbusiness ub ON ub.id = c.businessID
						SET";
		if( len(trim(arguments.email)) ){
			sqlString = sqlString & " c.email = :email,";
			structAppend( paramsStruct, { email = { value=left(arguments.email,40), cfsqltype="varchar" } } );
		}
		if( len(trim(arguments.phone)) ){
			sqlString = sqlString & " c.phone = :phone,";
			structAppend( paramsStruct, { phone = { value=left(arguments.phone,25), cfsqltype="varchar" } } );
		}
		if( len(trim(arguments.address)) ){
			sqlString = sqlString & " c.address = :address,";
			structAppend( paramsStruct, { address = { value=left(arguments.address,240), cfsqltype="varchar" } } );
		}
		if( len(trim(arguments.notes)) ){
			sqlString = sqlString & " c.notes = :notes,";
			structAppend( paramsStruct, { notes = { value=left(arguments.notes,110), cfsqltype="varchar" } } );
		}
		if( len(trim(arguments.tags)) ){
			sqlString = sqlString & " c.tags = :tags,";
			structAppend( paramsStruct, { tags = { value=left(arguments.tags,110), cfsqltype="varchar" } } );
		}
		if( len(trim(arguments.city)) ){
			sqlString = sqlString & " c.city = :city,";
			structAppend( paramsStruct, { city = { value=left(arguments.city,110), cfsqltype="varchar" } } );
		}
		sqlString = sqlString & " c.name = :name";
		sqlString = sqlString & " WHERE
							c.id = :id
						AND
							ub.id = :businessID";

		structAppend( paramsStruct, { name = { value=left(arguments.name,110), cfsqltype="varchar" } } );
		structAppend( paramsStruct, { id = { value=arguments.id, cfsqltype="integer" } } );
		structAppend( paramsStruct, { businessID = { value=request.businessID, cfsqltype="integer" } } );

		var qResult = {};
		queryExecute( sqlString, paramsStruct , { result="qResult" } );
		return qResult.recordCount;
	}
    // delete query
	public numeric function qCustomerDelete( required numeric id ) {
		var paramsStruct = {};
		var sqlString = "DELETE
							c
						FROM
							customer c
						INNER JOIN
							userbusiness b ON b.id = c.businessID
						WHERE
							c.id = :id
						AND
							b.id = :businessID";
		structAppend( paramsStruct, { id = { value=arguments.id, cfsqltype="integer" } } );
		structAppend( paramsStruct, { businessID = { value=request.businessID, cfsqltype="integer" } } );

		var qResult = {};
		queryExecute( sqlString, paramsStruct , { result="qResult" } );
		return qResult.recordCount;
	}

}
