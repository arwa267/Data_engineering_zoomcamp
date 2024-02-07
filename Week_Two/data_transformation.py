if 'transformer' not in globals():
    from mage_ai.data_preparation.decorators import transformer
if 'test' not in globals():
    from mage_ai.data_preparation.decorators import test


@transformer
def transform(data, *args, **kwargs):

    #Convert data column to date fields
    data['lpep_pickup_date'] = data['lpep_pickup_datetime'].dt.date
    data['lpep_dropoff_date'] = data['lpep_dropoff_datetime'].dt.date

    print("the unique days are",len(data['lpep_pickup_date'].unique()))

    #Keep only rows with passenger greater than 0
    data = data[(data['passenger_count'] > 0) & (data['trip_distance'] > 0)]

    data.rename(columns={'VendorID': 'vendor_id', 'RatecodeID':'rate_code_id','PULocationID':'pu_location_id','DOLocationID':'do_location_id' }, inplace=True)

    print("The unique Value of  the venddor id column is", data['vendor_id'].unique())



    #

    return data


@test
def test_output(output, *args) -> None:
    """
    Template code for testing the output of the block.
    """
    assert output is not None, 'The output is undefined'
    assert 'VendorID' not in output.columns, 'There is a problem in renaming'
    assert output['passenger_count'].isin([0]).sum()==0 , 'The filter did not work'
    assert output['trip_distance'].isin([0]).sum()==0 
    
    

