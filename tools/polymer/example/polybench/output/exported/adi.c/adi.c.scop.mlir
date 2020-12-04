#map0 = affine_map<()[s0] -> (s0 + 1)>
#map1 = affine_map<()[s0] -> (s0 - 1)>
module attributes {llvm.data_layout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128", llvm.target_triple = "x86_64-unknown-linux-gnu"}  {
  llvm.mlir.global internal constant @str9("%0.6f\0A\00")
  global_memref "private" @polybench_t_end : memref<1xf64>
  llvm.mlir.global internal constant @str8("Error return from gettimeofday: %d\00")
  llvm.func @printf(!llvm.ptr<i8>, ...) -> !llvm.i32
  llvm.func @gettimeofday(!llvm.ptr<struct<"struct.timeval", (i64, i64)>>, !llvm.ptr<struct<"struct.timezone", (i32, i32)>>) -> !llvm.i32
  global_memref "private" @polybench_t_start : memref<1xf64>
  llvm.mlir.global internal constant @str7("==END   DUMP_ARRAYS==\0A\00")
  llvm.mlir.global internal constant @str6("\0Aend   dump: %s\0A\00")
  llvm.mlir.global internal constant @str5("%0.2lf \00")
  llvm.mlir.global internal constant @str4("\0A\00")
  llvm.mlir.global internal constant @str3("u\00")
  llvm.mlir.global internal constant @str2("begin dump: %s\00")
  llvm.mlir.global internal constant @str1("==BEGIN DUMP_ARRAYS==\0A\00")
  llvm.mlir.global external @stderr() : !llvm.ptr<struct<"struct._IO_FILE", (i32, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<struct<"struct._IO_marker", (ptr<struct<"struct._IO_marker">>, ptr<struct<"struct._IO_FILE">>, i32, array<4 x i8>)>>, ptr<struct<"struct._IO_FILE">>, i32, i32, i64, i16, i8, array<1 x i8>, ptr<i8>, i64, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, i64, i32, array<20 x i8>)>>
  llvm.func @fprintf(!llvm.ptr<struct<"struct._IO_FILE", (i32, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<struct<"struct._IO_marker", (ptr<struct<"struct._IO_marker">>, ptr<struct<"struct._IO_FILE">>, i32, array<4 x i8>)>>, ptr<struct<"struct._IO_FILE">>, i32, i32, i64, i16, i8, array<1 x i8>, ptr<i8>, i64, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, i64, i32, array<20 x i8>)>>, !llvm.ptr<i8>, ...) -> !llvm.i32
  llvm.mlir.global internal constant @str0("\00")
  llvm.func @strcmp(!llvm.ptr<i8>, !llvm.ptr<i8>) -> !llvm.i32
  func @main(%arg0: i32, %arg1: !llvm.ptr<ptr<i8>>) -> i32 {
    %c1000_i32 = constant 1000 : i32
    %c500_i32 = constant 500 : i32
    %c42_i32 = constant 42 : i32
    %true = constant true
    %false = constant false
    %c0_i32 = constant 0 : i32
    %0 = alloc() : memref<1000x1000xf64>
    %1 = alloc() : memref<1000x1000xf64>
    %2 = alloc() : memref<1000x1000xf64>
    %3 = alloc() : memref<1000x1000xf64>
    call @init_array(%c1000_i32, %0) : (i32, memref<1000x1000xf64>) -> ()
    call @polybench_timer_start() : () -> ()
    call @kernel_adi(%c500_i32, %c1000_i32, %0, %1, %2, %3) : (i32, i32, memref<1000x1000xf64>, memref<1000x1000xf64>, memref<1000x1000xf64>, memref<1000x1000xf64>) -> ()
    call @polybench_timer_stop() : () -> ()
    call @polybench_timer_print() : () -> ()
    %4 = cmpi "sgt", %arg0, %c42_i32 : i32
    %5 = scf.if %4 -> (i1) {
      %6 = llvm.load %arg1 : !llvm.ptr<ptr<i8>>
      %7 = llvm.mlir.addressof @str0 : !llvm.ptr<array<1 x i8>>
      %8 = llvm.mlir.constant(0 : index) : !llvm.i64
      %9 = llvm.getelementptr %7[%8, %8] : (!llvm.ptr<array<1 x i8>>, !llvm.i64, !llvm.i64) -> !llvm.ptr<i8>
      %10 = llvm.call @strcmp(%6, %9) : (!llvm.ptr<i8>, !llvm.ptr<i8>) -> !llvm.i32
      %11 = llvm.mlir.cast %10 : !llvm.i32 to i32
      %12 = trunci %11 : i32 to i1
      %13 = xor %12, %true : i1
      scf.yield %13 : i1
    } else {
      scf.yield %false : i1
    }
    scf.if %5 {
      call @print_array(%c1000_i32, %0) : (i32, memref<1000x1000xf64>) -> ()
    }
    return %c0_i32 : i32
  }
  func @init_array(%arg0: i32, %arg1: memref<1000x1000xf64>) {
    %c0_i32 = constant 0 : i32
    %c1_i32 = constant 1 : i32
    br ^bb1(%c0_i32 : i32)
  ^bb1(%0: i32):  // 2 preds: ^bb0, ^bb5
    %1 = cmpi "slt", %0, %arg0 : i32
    %2 = index_cast %0 : i32 to index
    cond_br %1, ^bb3(%c0_i32 : i32), ^bb2
  ^bb2:  // pred: ^bb1
    return
  ^bb3(%3: i32):  // 2 preds: ^bb1, ^bb4
    %4 = cmpi "slt", %3, %arg0 : i32
    %5 = index_cast %3 : i32 to index
    cond_br %4, ^bb4, ^bb5
  ^bb4:  // pred: ^bb3
    %6 = addi %0, %arg0 : i32
    %7 = subi %6, %3 : i32
    %8 = sitofp %7 : i32 to f64
    %9 = sitofp %arg0 : i32 to f64
    %10 = divf %8, %9 : f64
    store %10, %arg1[%2, %5] : memref<1000x1000xf64>
    %11 = addi %3, %c1_i32 : i32
    br ^bb3(%11 : i32)
  ^bb5:  // pred: ^bb3
    %12 = addi %0, %c1_i32 : i32
    br ^bb1(%12 : i32)
  }
  func @polybench_timer_start() {
    %c0 = constant 0 : index
    call @polybench_prepare_instruments() : () -> ()
    %0 = get_global_memref @polybench_t_start : memref<1xf64>
    %1 = call @rtclock() : () -> f64
    store %1, %0[%c0] : memref<1xf64>
    return
  }
  func @kernel_adi(%arg0: i32, %arg1: i32, %arg2: memref<1000x1000xf64>, %arg3: memref<1000x1000xf64>, %arg4: memref<1000x1000xf64>, %arg5: memref<1000x1000xf64>) {
    %0 = index_cast %arg1 : i32 to index
    %1 = alloca() : memref<1xf64>
    call @S0(%1, %arg1, %arg0) : (memref<1xf64>, i32, i32) -> ()
    %2 = alloca() : memref<1xf64>
    call @S1(%2, %arg1, %arg0) : (memref<1xf64>, i32, i32) -> ()
    %3 = alloca() : memref<1xf64>
    call @S2(%3, %arg1, %arg0) : (memref<1xf64>, i32, i32) -> ()
    %4 = alloca() : memref<1xf64>
    call @S3(%4, %arg1, %arg0) : (memref<1xf64>, i32, i32) -> ()
    %5 = index_cast %arg0 : i32 to index
    affine.for %arg6 = 1 to #map0()[%5] {
      affine.for %arg7 = 1 to #map1()[%0] {
        call @S4(%arg3, %arg7) : (memref<1000x1000xf64>, index) -> ()
        call @S5(%arg4, %arg7) : (memref<1000x1000xf64>, index) -> ()
        call @S6(%arg5, %arg7, %arg3) : (memref<1000x1000xf64>, index, memref<1000x1000xf64>) -> ()
        affine.for %arg8 = 1 to #map1()[%0] {
          call @S7(%arg4, %arg7, %arg8, %2, %1) : (memref<1000x1000xf64>, index, index, memref<1xf64>, memref<1xf64>) -> ()
          call @S8(%arg5, %arg7, %arg8, %2, %arg4, %1, %arg2, %3) : (memref<1000x1000xf64>, index, index, memref<1xf64>, memref<1000x1000xf64>, memref<1xf64>, memref<1000x1000xf64>, memref<1xf64>) -> ()
        }
        call @S9(%arg3, %arg7, %0) : (memref<1000x1000xf64>, index, index) -> ()
        affine.for %arg8 = 1 to #map1()[%0] {
          call @S10(%arg3, %arg8, %arg7, %0, %arg5, %arg4) : (memref<1000x1000xf64>, index, index, index, memref<1000x1000xf64>, memref<1000x1000xf64>) -> ()
        }
      }
      affine.for %arg7 = 1 to #map1()[%0] {
        call @S11(%arg2, %arg7) : (memref<1000x1000xf64>, index) -> ()
        call @S12(%arg4, %arg7) : (memref<1000x1000xf64>, index) -> ()
        call @S13(%arg5, %arg7, %arg2) : (memref<1000x1000xf64>, index, memref<1000x1000xf64>) -> ()
        affine.for %arg8 = 1 to #map1()[%0] {
          call @S14(%arg4, %arg7, %arg8, %4, %3) : (memref<1000x1000xf64>, index, index, memref<1xf64>, memref<1xf64>) -> ()
          call @S15(%arg5, %arg7, %arg8, %4, %arg4, %3, %arg3, %1) : (memref<1000x1000xf64>, index, index, memref<1xf64>, memref<1000x1000xf64>, memref<1xf64>, memref<1000x1000xf64>, memref<1xf64>) -> ()
        }
        call @S16(%arg2, %arg7, %0) : (memref<1000x1000xf64>, index, index) -> ()
        affine.for %arg8 = 1 to #map1()[%0] {
          call @S17(%arg2, %arg7, %arg8, %0, %arg5, %arg4) : (memref<1000x1000xf64>, index, index, index, memref<1000x1000xf64>, memref<1000x1000xf64>) -> ()
        }
      }
    }
    return
  }
  func @polybench_timer_stop() {
    %c0 = constant 0 : index
    %0 = get_global_memref @polybench_t_end : memref<1xf64>
    %1 = call @rtclock() : () -> f64
    store %1, %0[%c0] : memref<1xf64>
    return
  }
  func @polybench_timer_print() {
    %c0 = constant 0 : index
    %0 = llvm.mlir.addressof @str9 : !llvm.ptr<array<7 x i8>>
    %1 = llvm.mlir.constant(0 : index) : !llvm.i64
    %2 = llvm.getelementptr %0[%1, %1] : (!llvm.ptr<array<7 x i8>>, !llvm.i64, !llvm.i64) -> !llvm.ptr<i8>
    %3 = get_global_memref @polybench_t_end : memref<1xf64>
    %4 = load %3[%c0] : memref<1xf64>
    %5 = get_global_memref @polybench_t_start : memref<1xf64>
    %6 = load %5[%c0] : memref<1xf64>
    %7 = subf %4, %6 : f64
    %8 = llvm.mlir.cast %7 : f64 to !llvm.double
    %9 = llvm.call @printf(%2, %8) : (!llvm.ptr<i8>, !llvm.double) -> !llvm.i32
    return
  }
  func @print_array(%arg0: i32, %arg1: memref<1000x1000xf64>) {
    %c0_i32 = constant 0 : i32
    %c20_i32 = constant 20 : i32
    %c1_i32 = constant 1 : i32
    %0 = llvm.mlir.addressof @stderr : !llvm.ptr<ptr<struct<"struct._IO_FILE", (i32, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<struct<"struct._IO_marker", (ptr<struct<"struct._IO_marker">>, ptr<struct<"struct._IO_FILE">>, i32, array<4 x i8>)>>, ptr<struct<"struct._IO_FILE">>, i32, i32, i64, i16, i8, array<1 x i8>, ptr<i8>, i64, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, i64, i32, array<20 x i8>)>>>
    %1 = llvm.load %0 : !llvm.ptr<ptr<struct<"struct._IO_FILE", (i32, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<struct<"struct._IO_marker", (ptr<struct<"struct._IO_marker">>, ptr<struct<"struct._IO_FILE">>, i32, array<4 x i8>)>>, ptr<struct<"struct._IO_FILE">>, i32, i32, i64, i16, i8, array<1 x i8>, ptr<i8>, i64, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, i64, i32, array<20 x i8>)>>>
    %2 = llvm.mlir.addressof @str1 : !llvm.ptr<array<23 x i8>>
    %3 = llvm.mlir.constant(0 : index) : !llvm.i64
    %4 = llvm.getelementptr %2[%3, %3] : (!llvm.ptr<array<23 x i8>>, !llvm.i64, !llvm.i64) -> !llvm.ptr<i8>
    %5 = llvm.call @fprintf(%1, %4) : (!llvm.ptr<struct<"struct._IO_FILE", (i32, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<struct<"struct._IO_marker", (ptr<struct<"struct._IO_marker">>, ptr<struct<"struct._IO_FILE">>, i32, array<4 x i8>)>>, ptr<struct<"struct._IO_FILE">>, i32, i32, i64, i16, i8, array<1 x i8>, ptr<i8>, i64, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, i64, i32, array<20 x i8>)>>, !llvm.ptr<i8>) -> !llvm.i32
    %6 = llvm.mlir.addressof @stderr : !llvm.ptr<ptr<struct<"struct._IO_FILE", (i32, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<struct<"struct._IO_marker", (ptr<struct<"struct._IO_marker">>, ptr<struct<"struct._IO_FILE">>, i32, array<4 x i8>)>>, ptr<struct<"struct._IO_FILE">>, i32, i32, i64, i16, i8, array<1 x i8>, ptr<i8>, i64, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, i64, i32, array<20 x i8>)>>>
    %7 = llvm.load %6 : !llvm.ptr<ptr<struct<"struct._IO_FILE", (i32, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<struct<"struct._IO_marker", (ptr<struct<"struct._IO_marker">>, ptr<struct<"struct._IO_FILE">>, i32, array<4 x i8>)>>, ptr<struct<"struct._IO_FILE">>, i32, i32, i64, i16, i8, array<1 x i8>, ptr<i8>, i64, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, i64, i32, array<20 x i8>)>>>
    %8 = llvm.mlir.addressof @str2 : !llvm.ptr<array<15 x i8>>
    %9 = llvm.getelementptr %8[%3, %3] : (!llvm.ptr<array<15 x i8>>, !llvm.i64, !llvm.i64) -> !llvm.ptr<i8>
    %10 = llvm.mlir.addressof @str3 : !llvm.ptr<array<2 x i8>>
    %11 = llvm.getelementptr %10[%3, %3] : (!llvm.ptr<array<2 x i8>>, !llvm.i64, !llvm.i64) -> !llvm.ptr<i8>
    %12 = llvm.call @fprintf(%7, %9, %11) : (!llvm.ptr<struct<"struct._IO_FILE", (i32, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<struct<"struct._IO_marker", (ptr<struct<"struct._IO_marker">>, ptr<struct<"struct._IO_FILE">>, i32, array<4 x i8>)>>, ptr<struct<"struct._IO_FILE">>, i32, i32, i64, i16, i8, array<1 x i8>, ptr<i8>, i64, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, i64, i32, array<20 x i8>)>>, !llvm.ptr<i8>, !llvm.ptr<i8>) -> !llvm.i32
    br ^bb1(%c0_i32 : i32)
  ^bb1(%13: i32):  // 2 preds: ^bb0, ^bb5
    %14 = cmpi "slt", %13, %arg0 : i32
    %15 = index_cast %13 : i32 to index
    cond_br %14, ^bb3(%c0_i32 : i32), ^bb2
  ^bb2:  // pred: ^bb1
    %16 = llvm.mlir.addressof @stderr : !llvm.ptr<ptr<struct<"struct._IO_FILE", (i32, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<struct<"struct._IO_marker", (ptr<struct<"struct._IO_marker">>, ptr<struct<"struct._IO_FILE">>, i32, array<4 x i8>)>>, ptr<struct<"struct._IO_FILE">>, i32, i32, i64, i16, i8, array<1 x i8>, ptr<i8>, i64, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, i64, i32, array<20 x i8>)>>>
    %17 = llvm.load %16 : !llvm.ptr<ptr<struct<"struct._IO_FILE", (i32, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<struct<"struct._IO_marker", (ptr<struct<"struct._IO_marker">>, ptr<struct<"struct._IO_FILE">>, i32, array<4 x i8>)>>, ptr<struct<"struct._IO_FILE">>, i32, i32, i64, i16, i8, array<1 x i8>, ptr<i8>, i64, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, i64, i32, array<20 x i8>)>>>
    %18 = llvm.mlir.addressof @str6 : !llvm.ptr<array<17 x i8>>
    %19 = llvm.getelementptr %18[%3, %3] : (!llvm.ptr<array<17 x i8>>, !llvm.i64, !llvm.i64) -> !llvm.ptr<i8>
    %20 = llvm.mlir.addressof @str3 : !llvm.ptr<array<2 x i8>>
    %21 = llvm.getelementptr %20[%3, %3] : (!llvm.ptr<array<2 x i8>>, !llvm.i64, !llvm.i64) -> !llvm.ptr<i8>
    %22 = llvm.call @fprintf(%17, %19, %21) : (!llvm.ptr<struct<"struct._IO_FILE", (i32, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<struct<"struct._IO_marker", (ptr<struct<"struct._IO_marker">>, ptr<struct<"struct._IO_FILE">>, i32, array<4 x i8>)>>, ptr<struct<"struct._IO_FILE">>, i32, i32, i64, i16, i8, array<1 x i8>, ptr<i8>, i64, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, i64, i32, array<20 x i8>)>>, !llvm.ptr<i8>, !llvm.ptr<i8>) -> !llvm.i32
    %23 = llvm.mlir.addressof @stderr : !llvm.ptr<ptr<struct<"struct._IO_FILE", (i32, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<struct<"struct._IO_marker", (ptr<struct<"struct._IO_marker">>, ptr<struct<"struct._IO_FILE">>, i32, array<4 x i8>)>>, ptr<struct<"struct._IO_FILE">>, i32, i32, i64, i16, i8, array<1 x i8>, ptr<i8>, i64, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, i64, i32, array<20 x i8>)>>>
    %24 = llvm.load %23 : !llvm.ptr<ptr<struct<"struct._IO_FILE", (i32, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<struct<"struct._IO_marker", (ptr<struct<"struct._IO_marker">>, ptr<struct<"struct._IO_FILE">>, i32, array<4 x i8>)>>, ptr<struct<"struct._IO_FILE">>, i32, i32, i64, i16, i8, array<1 x i8>, ptr<i8>, i64, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, i64, i32, array<20 x i8>)>>>
    %25 = llvm.mlir.addressof @str7 : !llvm.ptr<array<23 x i8>>
    %26 = llvm.getelementptr %25[%3, %3] : (!llvm.ptr<array<23 x i8>>, !llvm.i64, !llvm.i64) -> !llvm.ptr<i8>
    %27 = llvm.call @fprintf(%24, %26) : (!llvm.ptr<struct<"struct._IO_FILE", (i32, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<struct<"struct._IO_marker", (ptr<struct<"struct._IO_marker">>, ptr<struct<"struct._IO_FILE">>, i32, array<4 x i8>)>>, ptr<struct<"struct._IO_FILE">>, i32, i32, i64, i16, i8, array<1 x i8>, ptr<i8>, i64, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, i64, i32, array<20 x i8>)>>, !llvm.ptr<i8>) -> !llvm.i32
    return
  ^bb3(%28: i32):  // 2 preds: ^bb1, ^bb4
    %29 = cmpi "slt", %28, %arg0 : i32
    %30 = index_cast %28 : i32 to index
    cond_br %29, ^bb4, ^bb5
  ^bb4:  // pred: ^bb3
    %31 = muli %13, %arg0 : i32
    %32 = addi %31, %28 : i32
    %33 = remi_signed %32, %c20_i32 : i32
    %34 = cmpi "eq", %33, %c0_i32 : i32
    scf.if %34 {
      %44 = llvm.mlir.addressof @stderr : !llvm.ptr<ptr<struct<"struct._IO_FILE", (i32, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<struct<"struct._IO_marker", (ptr<struct<"struct._IO_marker">>, ptr<struct<"struct._IO_FILE">>, i32, array<4 x i8>)>>, ptr<struct<"struct._IO_FILE">>, i32, i32, i64, i16, i8, array<1 x i8>, ptr<i8>, i64, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, i64, i32, array<20 x i8>)>>>
      %45 = llvm.load %44 : !llvm.ptr<ptr<struct<"struct._IO_FILE", (i32, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<struct<"struct._IO_marker", (ptr<struct<"struct._IO_marker">>, ptr<struct<"struct._IO_FILE">>, i32, array<4 x i8>)>>, ptr<struct<"struct._IO_FILE">>, i32, i32, i64, i16, i8, array<1 x i8>, ptr<i8>, i64, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, i64, i32, array<20 x i8>)>>>
      %46 = llvm.mlir.addressof @str4 : !llvm.ptr<array<2 x i8>>
      %47 = llvm.getelementptr %46[%3, %3] : (!llvm.ptr<array<2 x i8>>, !llvm.i64, !llvm.i64) -> !llvm.ptr<i8>
      %48 = llvm.call @fprintf(%45, %47) : (!llvm.ptr<struct<"struct._IO_FILE", (i32, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<struct<"struct._IO_marker", (ptr<struct<"struct._IO_marker">>, ptr<struct<"struct._IO_FILE">>, i32, array<4 x i8>)>>, ptr<struct<"struct._IO_FILE">>, i32, i32, i64, i16, i8, array<1 x i8>, ptr<i8>, i64, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, i64, i32, array<20 x i8>)>>, !llvm.ptr<i8>) -> !llvm.i32
    }
    %35 = llvm.mlir.addressof @stderr : !llvm.ptr<ptr<struct<"struct._IO_FILE", (i32, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<struct<"struct._IO_marker", (ptr<struct<"struct._IO_marker">>, ptr<struct<"struct._IO_FILE">>, i32, array<4 x i8>)>>, ptr<struct<"struct._IO_FILE">>, i32, i32, i64, i16, i8, array<1 x i8>, ptr<i8>, i64, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, i64, i32, array<20 x i8>)>>>
    %36 = llvm.load %35 : !llvm.ptr<ptr<struct<"struct._IO_FILE", (i32, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<struct<"struct._IO_marker", (ptr<struct<"struct._IO_marker">>, ptr<struct<"struct._IO_FILE">>, i32, array<4 x i8>)>>, ptr<struct<"struct._IO_FILE">>, i32, i32, i64, i16, i8, array<1 x i8>, ptr<i8>, i64, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, i64, i32, array<20 x i8>)>>>
    %37 = llvm.mlir.addressof @str5 : !llvm.ptr<array<8 x i8>>
    %38 = llvm.getelementptr %37[%3, %3] : (!llvm.ptr<array<8 x i8>>, !llvm.i64, !llvm.i64) -> !llvm.ptr<i8>
    %39 = load %arg1[%15, %30] : memref<1000x1000xf64>
    %40 = llvm.mlir.cast %39 : f64 to !llvm.double
    %41 = llvm.call @fprintf(%36, %38, %40) : (!llvm.ptr<struct<"struct._IO_FILE", (i32, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<struct<"struct._IO_marker", (ptr<struct<"struct._IO_marker">>, ptr<struct<"struct._IO_FILE">>, i32, array<4 x i8>)>>, ptr<struct<"struct._IO_FILE">>, i32, i32, i64, i16, i8, array<1 x i8>, ptr<i8>, i64, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, i64, i32, array<20 x i8>)>>, !llvm.ptr<i8>, !llvm.double) -> !llvm.i32
    %42 = addi %28, %c1_i32 : i32
    br ^bb3(%42 : i32)
  ^bb5:  // pred: ^bb3
    %43 = addi %13, %c1_i32 : i32
    br ^bb1(%43 : i32)
  }
  func private @free(memref<?xi8>)
  func @polybench_prepare_instruments() {
    return
  }
  func @rtclock() -> f64 {
    %c0_i32 = constant 0 : i32
    %cst = constant 9.9999999999999995E-7 : f64
    %0 = llvm.mlir.constant(1 : index) : !llvm.i64
    %1 = llvm.alloca %0 x !llvm.struct<"struct.timeval", (i64, i64)> : (!llvm.i64) -> !llvm.ptr<struct<"struct.timeval", (i64, i64)>>
    %2 = llvm.mlir.null : !llvm.ptr<struct<"struct.timezone", (i32, i32)>>
    %3 = llvm.call @gettimeofday(%1, %2) : (!llvm.ptr<struct<"struct.timeval", (i64, i64)>>, !llvm.ptr<struct<"struct.timezone", (i32, i32)>>) -> !llvm.i32
    %4 = llvm.mlir.cast %3 : !llvm.i32 to i32
    %5 = llvm.load %1 : !llvm.ptr<struct<"struct.timeval", (i64, i64)>>
    %6 = llvm.extractvalue %5[0] : !llvm.struct<"struct.timeval", (i64, i64)>
    %7 = llvm.mlir.cast %6 : !llvm.i64 to i64
    %8 = llvm.extractvalue %5[1] : !llvm.struct<"struct.timeval", (i64, i64)>
    %9 = llvm.mlir.cast %8 : !llvm.i64 to i64
    %10 = cmpi "ne", %4, %c0_i32 : i32
    scf.if %10 {
      %15 = llvm.mlir.addressof @str8 : !llvm.ptr<array<35 x i8>>
      %16 = llvm.mlir.constant(0 : index) : !llvm.i64
      %17 = llvm.getelementptr %15[%16, %16] : (!llvm.ptr<array<35 x i8>>, !llvm.i64, !llvm.i64) -> !llvm.ptr<i8>
      %18 = llvm.mlir.cast %4 : i32 to !llvm.i32
      %19 = llvm.call @printf(%17, %18) : (!llvm.ptr<i8>, !llvm.i32) -> !llvm.i32
    }
    %11 = sitofp %7 : i64 to f64
    %12 = sitofp %9 : i64 to f64
    %13 = mulf %12, %cst : f64
    %14 = addf %11, %13 : f64
    return %14 : f64
  }
  func private @S0(%arg0: memref<1xf64>, %arg1: i32, %arg2: i32) attributes {scop.stmt} {
    %0 = sitofp %arg2 : i32 to f64
    %cst = constant 1.000000e+00 : f64
    %cst_0 = constant 1.000000e+00 : f64
    %1 = divf %cst_0, %0 : f64
    %2 = sitofp %arg1 : i32 to f64
    %cst_1 = constant 1.000000e+00 : f64
    %3 = divf %cst_1, %2 : f64
    %4 = mulf %3, %3 : f64
    %cst_2 = constant 2.000000e+00 : f64
    %cst_3 = constant 2.000000e+00 : f64
    %5 = mulf %cst_3, %1 : f64
    %6 = divf %5, %4 : f64
    %7 = negf %6 : f64
    %cst_4 = constant 2.000000e+00 : f64
    %8 = divf %7, %cst_4 : f64
    affine.store %8, %arg0[0] : memref<1xf64>
    return
  }
  func private @S1(%arg0: memref<1xf64>, %arg1: i32, %arg2: i32) attributes {scop.stmt} {
    %cst = constant 2.000000e+00 : f64
    %0 = sitofp %arg2 : i32 to f64
    %cst_0 = constant 1.000000e+00 : f64
    %cst_1 = constant 1.000000e+00 : f64
    %1 = divf %cst_1, %0 : f64
    %cst_2 = constant 2.000000e+00 : f64
    %2 = mulf %cst_2, %1 : f64
    %3 = sitofp %arg1 : i32 to f64
    %cst_3 = constant 1.000000e+00 : f64
    %4 = divf %cst_3, %3 : f64
    %5 = mulf %4, %4 : f64
    %6 = divf %2, %5 : f64
    %cst_4 = constant 1.000000e+00 : f64
    %7 = addf %cst_4, %6 : f64
    affine.store %7, %arg0[0] : memref<1xf64>
    return
  }
  func private @S2(%arg0: memref<1xf64>, %arg1: i32, %arg2: i32) attributes {scop.stmt} {
    %0 = sitofp %arg2 : i32 to f64
    %cst = constant 1.000000e+00 : f64
    %cst_0 = constant 1.000000e+00 : f64
    %1 = divf %cst_0, %0 : f64
    %cst_1 = constant 1.000000e+00 : f64
    %2 = mulf %cst_1, %1 : f64
    %3 = sitofp %arg1 : i32 to f64
    %cst_2 = constant 1.000000e+00 : f64
    %4 = divf %cst_2, %3 : f64
    %5 = mulf %4, %4 : f64
    %6 = divf %2, %5 : f64
    %7 = negf %6 : f64
    %cst_3 = constant 2.000000e+00 : f64
    %cst_4 = constant 2.000000e+00 : f64
    %8 = divf %7, %cst_4 : f64
    affine.store %8, %arg0[0] : memref<1xf64>
    return
  }
  func private @S3(%arg0: memref<1xf64>, %arg1: i32, %arg2: i32) attributes {scop.stmt} {
    %0 = sitofp %arg2 : i32 to f64
    %cst = constant 1.000000e+00 : f64
    %cst_0 = constant 1.000000e+00 : f64
    %1 = divf %cst_0, %0 : f64
    %cst_1 = constant 1.000000e+00 : f64
    %2 = mulf %cst_1, %1 : f64
    %3 = sitofp %arg1 : i32 to f64
    %cst_2 = constant 1.000000e+00 : f64
    %4 = divf %cst_2, %3 : f64
    %5 = mulf %4, %4 : f64
    %6 = divf %2, %5 : f64
    %cst_3 = constant 1.000000e+00 : f64
    %7 = addf %cst_3, %6 : f64
    affine.store %7, %arg0[0] : memref<1xf64>
    return
  }
  func private @S4(%arg0: memref<1000x1000xf64>, %arg1: index) attributes {scop.stmt} {
    %cst = constant 1.000000e+00 : f64
    %cst_0 = constant 1.000000e+00 : f64
    affine.store %cst_0, %arg0[0, %arg1] : memref<1000x1000xf64>
    return
  }
  func private @S5(%arg0: memref<1000x1000xf64>, %arg1: index) attributes {scop.stmt} {
    %cst = constant 0.000000e+00 : f64
    %cst_0 = constant 0.000000e+00 : f64
    affine.store %cst_0, %arg0[%arg1, 0] : memref<1000x1000xf64>
    return
  }
  func private @S6(%arg0: memref<1000x1000xf64>, %arg1: index, %arg2: memref<1000x1000xf64>) attributes {scop.stmt} {
    %0 = affine.load %arg2[0, %arg1] : memref<1000x1000xf64>
    affine.store %0, %arg0[%arg1, 0] : memref<1000x1000xf64>
    return
  }
  func private @S7(%arg0: memref<1000x1000xf64>, %arg1: index, %arg2: index, %arg3: memref<1xf64>, %arg4: memref<1xf64>) attributes {scop.stmt} {
    %0 = affine.load %arg4[0] : memref<1xf64>
    %1 = negf %0 : f64
    %2 = affine.load %arg0[%arg1, %arg2 - 1] : memref<1000x1000xf64>
    %3 = mulf %0, %2 : f64
    %4 = affine.load %arg3[0] : memref<1xf64>
    %5 = addf %3, %4 : f64
    %6 = divf %1, %5 : f64
    affine.store %6, %arg0[%arg1, %arg2] : memref<1000x1000xf64>
    return
  }
  func private @S8(%arg0: memref<1000x1000xf64>, %arg1: index, %arg2: index, %arg3: memref<1xf64>, %arg4: memref<1000x1000xf64>, %arg5: memref<1xf64>, %arg6: memref<1000x1000xf64>, %arg7: memref<1xf64>) attributes {scop.stmt} {
    %0 = affine.load %arg6[%arg2, %arg1 - 1] : memref<1000x1000xf64>
    %cst = constant 1.000000e+00 : f64
    %cst_0 = constant 2.000000e+00 : f64
    %1 = affine.load %arg6[%arg2, %arg1] : memref<1000x1000xf64>
    %2 = affine.load %arg7[0] : memref<1xf64>
    %cst_1 = constant 2.000000e+00 : f64
    %3 = mulf %cst_1, %2 : f64
    %cst_2 = constant 1.000000e+00 : f64
    %4 = addf %cst_2, %3 : f64
    %5 = mulf %4, %1 : f64
    %6 = negf %2 : f64
    %7 = mulf %6, %0 : f64
    %8 = addf %7, %5 : f64
    %9 = affine.load %arg6[%arg2, %arg1 + 1] : memref<1000x1000xf64>
    %10 = mulf %2, %9 : f64
    %11 = subf %8, %10 : f64
    %12 = affine.load %arg0[%arg1, %arg2 - 1] : memref<1000x1000xf64>
    %13 = affine.load %arg5[0] : memref<1xf64>
    %14 = mulf %13, %12 : f64
    %15 = subf %11, %14 : f64
    %16 = affine.load %arg4[%arg1, %arg2 - 1] : memref<1000x1000xf64>
    %17 = mulf %13, %16 : f64
    %18 = affine.load %arg3[0] : memref<1xf64>
    %19 = addf %17, %18 : f64
    %20 = divf %15, %19 : f64
    affine.store %20, %arg0[%arg1, %arg2] : memref<1000x1000xf64>
    return
  }
  func private @S9(%arg0: memref<1000x1000xf64>, %arg1: index, %arg2: index) attributes {scop.stmt} {
    %cst = constant 1.000000e+00 : f64
    %cst_0 = constant 1.000000e+00 : f64
    affine.store %cst_0, %arg0[symbol(%arg2) - 1, %arg1] : memref<1000x1000xf64>
    return
  }
  func private @S10(%arg0: memref<1000x1000xf64>, %arg1: index, %arg2: index, %arg3: index, %arg4: memref<1000x1000xf64>, %arg5: memref<1000x1000xf64>) attributes {scop.stmt} {
    %0 = affine.load %arg5[%arg2, -%arg1 + symbol(%arg3) - 1] : memref<1000x1000xf64>
    %1 = affine.load %arg0[-%arg1 + symbol(%arg3), %arg2] : memref<1000x1000xf64>
    %2 = mulf %0, %1 : f64
    %3 = affine.load %arg4[%arg2, -%arg1 + symbol(%arg3) - 1] : memref<1000x1000xf64>
    %4 = addf %2, %3 : f64
    affine.store %4, %arg0[-%arg1 + symbol(%arg3) - 1, %arg2] : memref<1000x1000xf64>
    return
  }
  func private @S11(%arg0: memref<1000x1000xf64>, %arg1: index) attributes {scop.stmt} {
    %cst = constant 1.000000e+00 : f64
    %cst_0 = constant 1.000000e+00 : f64
    affine.store %cst_0, %arg0[%arg1, 0] : memref<1000x1000xf64>
    return
  }
  func private @S12(%arg0: memref<1000x1000xf64>, %arg1: index) attributes {scop.stmt} {
    %cst = constant 0.000000e+00 : f64
    %cst_0 = constant 0.000000e+00 : f64
    affine.store %cst_0, %arg0[%arg1, 0] : memref<1000x1000xf64>
    return
  }
  func private @S13(%arg0: memref<1000x1000xf64>, %arg1: index, %arg2: memref<1000x1000xf64>) attributes {scop.stmt} {
    %0 = affine.load %arg2[%arg1, 0] : memref<1000x1000xf64>
    affine.store %0, %arg0[%arg1, 0] : memref<1000x1000xf64>
    return
  }
  func private @S14(%arg0: memref<1000x1000xf64>, %arg1: index, %arg2: index, %arg3: memref<1xf64>, %arg4: memref<1xf64>) attributes {scop.stmt} {
    %0 = affine.load %arg4[0] : memref<1xf64>
    %1 = negf %0 : f64
    %2 = affine.load %arg0[%arg1, %arg2 - 1] : memref<1000x1000xf64>
    %3 = mulf %0, %2 : f64
    %4 = affine.load %arg3[0] : memref<1xf64>
    %5 = addf %3, %4 : f64
    %6 = divf %1, %5 : f64
    affine.store %6, %arg0[%arg1, %arg2] : memref<1000x1000xf64>
    return
  }
  func private @S15(%arg0: memref<1000x1000xf64>, %arg1: index, %arg2: index, %arg3: memref<1xf64>, %arg4: memref<1000x1000xf64>, %arg5: memref<1xf64>, %arg6: memref<1000x1000xf64>, %arg7: memref<1xf64>) attributes {scop.stmt} {
    %0 = affine.load %arg6[%arg1 - 1, %arg2] : memref<1000x1000xf64>
    %cst = constant 1.000000e+00 : f64
    %cst_0 = constant 2.000000e+00 : f64
    %1 = affine.load %arg6[%arg1, %arg2] : memref<1000x1000xf64>
    %2 = affine.load %arg7[0] : memref<1xf64>
    %cst_1 = constant 2.000000e+00 : f64
    %3 = mulf %cst_1, %2 : f64
    %cst_2 = constant 1.000000e+00 : f64
    %4 = addf %cst_2, %3 : f64
    %5 = mulf %4, %1 : f64
    %6 = negf %2 : f64
    %7 = mulf %6, %0 : f64
    %8 = addf %7, %5 : f64
    %9 = affine.load %arg6[%arg1 + 1, %arg2] : memref<1000x1000xf64>
    %10 = mulf %2, %9 : f64
    %11 = subf %8, %10 : f64
    %12 = affine.load %arg0[%arg1, %arg2 - 1] : memref<1000x1000xf64>
    %13 = affine.load %arg5[0] : memref<1xf64>
    %14 = mulf %13, %12 : f64
    %15 = subf %11, %14 : f64
    %16 = affine.load %arg4[%arg1, %arg2 - 1] : memref<1000x1000xf64>
    %17 = mulf %13, %16 : f64
    %18 = affine.load %arg3[0] : memref<1xf64>
    %19 = addf %17, %18 : f64
    %20 = divf %15, %19 : f64
    affine.store %20, %arg0[%arg1, %arg2] : memref<1000x1000xf64>
    return
  }
  func private @S16(%arg0: memref<1000x1000xf64>, %arg1: index, %arg2: index) attributes {scop.stmt} {
    %cst = constant 1.000000e+00 : f64
    %cst_0 = constant 1.000000e+00 : f64
    affine.store %cst_0, %arg0[%arg1, symbol(%arg2) - 1] : memref<1000x1000xf64>
    return
  }
  func private @S17(%arg0: memref<1000x1000xf64>, %arg1: index, %arg2: index, %arg3: index, %arg4: memref<1000x1000xf64>, %arg5: memref<1000x1000xf64>) attributes {scop.stmt} {
    %0 = affine.load %arg5[%arg1, -%arg2 + symbol(%arg3) - 1] : memref<1000x1000xf64>
    %1 = affine.load %arg0[%arg1, -%arg2 + symbol(%arg3)] : memref<1000x1000xf64>
    %2 = mulf %0, %1 : f64
    %3 = affine.load %arg4[%arg1, -%arg2 + symbol(%arg3) - 1] : memref<1000x1000xf64>
    %4 = addf %2, %3 : f64
    affine.store %4, %arg0[%arg1, -%arg2 + symbol(%arg3) - 1] : memref<1000x1000xf64>
    return
  }
}
