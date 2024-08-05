# Etapa 1: Build
FROM node:18-alpine AS builder

# Define o diretório de trabalho dentro do contêiner
WORKDIR /usr/src/app

# Copia o package.json e o package-lock.json (se disponível)
COPY package*.json ./

# Instala as dependências
RUN npm install

# Copia o restante da aplicação para o diretório de trabalho
COPY . .

# Compila o projeto NestJS
RUN npm run build

# Etapa 2: Run
FROM node:18-alpine AS runner

# Define o diretório de trabalho dentro do contêiner
WORKDIR /usr/src/app

# Copia as dependências instaladas do estágio anterior
COPY --from=builder /usr/src/app/node_modules ./node_modules

# Copia os arquivos compilados do estágio anterior
COPY --from=builder /usr/src/app/dist ./dist

# Copia o arquivo de configuração
COPY --from=builder /usr/src/app/package*.json ./

# Define a variável de ambiente para produção
ENV NODE_ENV=production

# Expõe a porta da aplicação
EXPOSE 8080

# Comando para rodar a aplicação
CMD ["node", "dist/main"]
