package columbian;

import spwrap.mappers.ResultSetMapper;
import spwrap.result.Result;

public class SupplierCoffee implements ResultSetMapper<SupplierCoffee> {
    private String supplierName, coffeeName;

    @Override
    public SupplierCoffee map(Result<?> result) {
        SupplierCoffee supplierCoffee = new SupplierCoffee();
        supplierCoffee.supplierName = result.getString(1);
        supplierCoffee.coffeeName = result.getString(2);
        return supplierCoffee;
    }

    @Override
    public String toString() {
        return "SupplierCoffee{" +
                "supplierName='" + supplierName + '\'' +
                ", coffeeName='" + coffeeName + '\'' +
                '}';
    }
}
