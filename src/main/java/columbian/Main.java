package columbian;

import spwrap.Config;
import spwrap.DAO;

import java.math.BigDecimal;
import java.util.List;

public class Main {

    public static void main(String[] args) {
        // In production, pass DataSource object to the Builder constructor
        DAO dao = new DAO.Builder("jdbc:mysql://localhost:3306/columbian", "root", "")
                .config(new Config().useStatusFields(false))
                .build();

        ColumbianDAO columbianDAO = dao.create(ColumbianDAO.class);

        List<SupplierCoffee> supplierCoffees = columbianDAO.showSuppliers();
        supplierCoffees.forEach(System.out::println);

        String coffee = "Colombian";
        String supplier = columbianDAO.getSupplierOfCoffee(coffee);
        System.out.printf("Supplier of the coffee '%s' is '%s'\n", coffee, supplier);


        BigDecimal newPrice = columbianDAO.raisePrice(coffee, 0.10f, BigDecimal.valueOf(19.99));
        System.out.printf("new price of '%s' is '%s'\n", coffee, newPrice);

    }
}
