import { PrismaClient } from "@prisma/client";

const prisma = new PrismaClient();

async function createUser() {
  try {
    // create a new user
    const user = await prisma.user.create({
      data: {
        role: "ADMIN",
        Profile: {
          create: {
            employeId: "124534",
            name: "Manas Jain Kuniya",
            position: "Inspector",
            password: "!123456#",
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

createUser();
