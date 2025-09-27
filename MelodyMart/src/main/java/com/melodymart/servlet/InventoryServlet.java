package main.java.com.melodymart.servlet;

import com.melodymart.dao.InstrumentDAO;
import com.melodymart.model.Instrument;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/InventoryServlet")
public class InventoryServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private InstrumentDAO instrumentDAO;

    @Override
    public void init() throws ServletException {
        instrumentDAO = new InstrumentDAO(); // ✅ initialize DAO
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // ✅ Fetch all instruments from DB
            List<Instrument> instruments = instrumentDAO.getAllInstruments();

            // ✅ Debug log (check Tomcat console to confirm data is loaded)
            if (instruments != null) {
                System.out.println("InventoryServlet → Instruments fetched: " + instruments.size());
                for (Instrument ins : instruments) {
                    System.out.println(" - " + ins.getInstrumentId() + " | " + ins.getName());
                }
            } else {
                System.out.println("InventoryServlet → instruments list is NULL");
            }

            // ✅ Attach list to request scope
            request.setAttribute("instruments", instruments);

            // ✅ Forward to seller dashboard JSP
            request.getRequestDispatcher("seller-dashboard.jsp").forward(request, response);


        } catch (SQLException e) {
            e.printStackTrace();
            throw new ServletException("Database error while fetching instruments", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // For now, POST behaves same as GET
        doGet(request, response);
    }
}
