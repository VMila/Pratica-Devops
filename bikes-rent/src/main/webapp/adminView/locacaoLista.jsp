<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
        <!DOCTYPE html>
        <html>

        <head>
            <meta charset="UTF-8">
            <script src="https://cdn.tailwindcss.com"></script>
            <script src="${pageContext.request.contextPath}/scripts/clientNotFound.js"></script>
            <!-- Atualize o caminho -->
            <title>Lista de locacaos</title>
        </head>

        <body class="bg-gray-100">
            <!-- MOSTRA A LISTA DE TODOAS AS LOCAÇÕES DO BANCO DE DADOS  -->
            <nav class="bg-white border-gray-200 dark:bg-gray-500">
                <div class="max-w-screen-xl flex flex-wrap items-center justify-between mx-auto p-4">
                    <a href="/" class="flex items-center space-x-3 rtl:space-x-reverse">
                        <img src="../imagemLogoSemFundo3.png"
                         class="h-8" alt="System Logo" />
                        <span class="self-center text-2xl font-semibold whitespace-nowrap dark:text-white font-elegant">
                            Bike Rent System</span>
                    </a>
                    <button data-collapse-toggle="navbar-default" type="button" class="inline-flex items-center p-2 w-10 h-10 justify-center text-sm text-gray-500 rounded-lg md:hidden hover:bg-gray-100 focus:outline-none focus:ring-2 focus:ring-gray-200 dark:text-gray-400 dark:hover:bg-gray-700 dark:focus:ring-gray-600" aria-controls="navbar-default" aria-expanded="false">
                        <span class="sr-only">Open main menu</span>
                        <svg class="w-5 h-5" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 17 14">
                            <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M1 1h15M1 7h15M1 13h15" />
                        </svg>
                    </button>
                    <div class="hidden w-full md:block md:w-auto" id="navbar-default">
                        <ul class="font-medium flex flex-col p-4 md:p-0 mt-4 border border-gray-100 rounded-lg bg-gray-50 md:flex-row md:space-x-8 rtl:space-x-reverse md:mt-0 md:border-0 md:bg-white dark:bg-gray-800 md:dark:bg-gray-500 dark:border-gray-700">
                            <li>
                                <a href="/cliente/" class="block py-2 px-3 text-gray-100 bg-blue-700 rounded md:bg-transparent md:text-blue-700 md:p-0 dark:text-white
                                 hover:text-blue-300 transition duration-300"
                                 aria-current="page">Cliente</a>
                            </li>
                            <li>
                                <a href="/locadoraLogged/" class="block py-2 px-3 md:text-blue-700 hover:text-blue-300 rounded hover:bg-gray-100 md:hover:bg-transparent md:border-0
                                 md:p-0 dark:text-white md:dark:hover:text-blue-200 dark:hover:bg-gray-700 dark:hover:text-white md:dark:hover:bg-transparent
                                 transition duration-300">
                                    Locadora</a>
                            </li>
                            <li>
                                <a href="/admin/" class="block py-2 px-3 md:text-blue-700 hover:text-blue-300 rounded hover:bg-gray-100 md:hover:bg-transparent md:border-0 md:p-0 dark:text-white
                                 md:dark:hover:text-blue-200 dark:hover:bg-gray-700 dark:hover:text-white md:dark:hover:bg-transparent transition duration-300">
                                    Admin</a>
                            </li>
                        </ul>
                    </div>
                </div>
            </nav>
            <div class="flex justify-center items-center h-screen">
                <div class="max-w-4xl w-full p-8 bg-white rounded shadow-lg text-center">
                    <h2 class="text-2xl font-bold text-gray-800 mb-4">Lista de Locações</h2>
                    <c:if test="${not empty listaLoc}">
                        <table class="w-full mx-auto">
                            <thead>
                                <tr class="bg-gray-100">
                                    <th class="border border-gray-300 px-4 py-2">ID</th>
                                    <th class="border border-gray-300 px-4 py-2">CNPJ</th>
                                    <th class="border border-gray-300 px-4 py-2">CPF</th>
                                    <th class="border border-gray-300 px-4 py-2">Data</th>
                                    <th class="border border-gray-300 px-4 py-2">Opções</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="locacao" items="${listaLoc}">
                                    <tr class="border-b border-gray-300">
                                        <td class="border border-gray-300 px-4 py-2">${locacao.id}</td>
                                        <td class="border border-gray-300 px-4 py-2">${locacao.cnpjLocadora}</td>
                                        <td class="border border-gray-300 px-4 py-2">${locacao.cpfCliente}</td>
                                        <td class="border border-gray-300 px-4 py-2">${locacao.registro}</td>
                                        <td class="border border-gray-300 px-4 py-2">
                                            <a href="${pageContext.request.contextPath}/admin/editarLocacao?id=${locacao.id}" class="text-blue-500 hover:underline">Update</a>
                                            <a href="${pageContext.request.contextPath}/admin/deletarLocacao?id=${locacao.id}" class="text-red-500 hover:underline ml-2 delete-link">Delete</a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </c:if>
                    <c:if test="${empty listaLoc}">
                        <p>Nenhuma locacao encontrado.</p>
                    </c:if>

                    <hr class="my-4">

                    <div class="flex justify-around">

                        <a href="${pageContext.request.contextPath}"
                        class="text-gray-500 hover:underline">Voltar à página inicial</a>

                    </div>
                </div>
            </div>
        </body>

</html>