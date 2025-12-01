<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
        <footer class="container-fluid text-center bg-black text-white p-3">
            &copy; <%= new SimpleDateFormat("yyyy").format(new Date()) %>. Desenvolvido por Breno Pimenta & Bruno Goes & Gabriel Siviero.
        </footer>
        <script src="http://igorescobar.github.io/jQuery-Mask-Plugin/js/jquery.mask.min.js"></script>
    </body>
</html>