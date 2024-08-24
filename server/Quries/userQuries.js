import { PrismaClient } from "@prisma/client";

const prisma = new PrismaClient();

async function createUser() {
  try {
    // create a new user
    const user = await prisma.users.create({
      data: {
        role: "ADMIN",
        Profile: {
          create: {
            employeId: "124",
            name: "Akshat Gupta",
            position: "Inspector",
            password: "!12)))8*",
          },
        },
      },
    });

    console.log("User created:", user);
  } catch (error) {
    console.error("Error creating user:", error);
  } finally {
    await prisma.$disconnect();
  }
}

// async function Login() {

// }

createUser();
