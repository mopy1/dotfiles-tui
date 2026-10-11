return {
  -- 1. Soporte especializado para Spring Boot (JavaHello/spring-boot.nvim)
  {
    "JavaHello/spring-boot.nvim",
    ft = "java",
    dependencies = {
      "neovim/nvim-lspconfig",
      "mfussenegger/nvim-jdtls",
    },
    opts = {},
  },
}
