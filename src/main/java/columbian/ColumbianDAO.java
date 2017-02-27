package columbian;

import spwrap.annotations.Param;
import spwrap.annotations.Scalar;
import spwrap.annotations.StoredProc;

import java.math.BigDecimal;
import java.util.List;

import static java.sql.Types.FLOAT;
import static java.sql.Types.NUMERIC;
import static java.sql.Types.VARCHAR;

public interface ColumbianDAO {

    @StoredProc("SHOW_SUPPLIERS")
    List<SupplierCoffee> showSuppliers();

    @Scalar(VARCHAR)
    @StoredProc("GET_SUPPLIER_OF_COFFEE")
    String getSupplierOfCoffee(@Param(VARCHAR) String coffeeName);

    @Scalar(NUMERIC)
    @StoredProc("RAISE_PRICE")
    BigDecimal raisePrice(@Param(VARCHAR)String coffeeName,
                          @Param(FLOAT)float maximumPercentage,
                          @Param(NUMERIC) BigDecimal newPrice);
}
