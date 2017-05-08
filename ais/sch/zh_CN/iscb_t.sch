/* 
================================================================================
檔案代號:iscb_t
檔案名稱:銷售額與稅額申報書主檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table iscb_t
(
iscbent       number(5)      ,/* 企業編碼 */
iscbcomp       varchar2(10)      ,/* 法人編碼 */
iscbsite       varchar2(10)      ,/* 申報單位 */
iscb200       number(5,0)      ,/* 申報年度 */
iscb201       number(5,0)      ,/* 申報月份 */
iscb202       number(10,0)      ,/* 使用發票份數 */
iscb001       number(20,6)      ,/* 三聯式發票,電子計算機發票應稅銷售額	 */
iscb002       number(20,6)      ,/* 三聯式發票,電子計算機發票稅額 	 */
iscb003       number(20,6)      ,/* NO USE */
iscb004       number(20,6)      ,/* 三聯式發票,電子計算機發票免稅銷售額 	 */
iscb005       number(20,6)      ,/* 收銀機發票(三聯式) 應稅銷售額  	 */
iscb006       number(20,6)      ,/* 收銀機發票(三聯式) 應稅稅額  	 */
iscb007       number(20,6)      ,/* 非經海關出口零稅率銷售額 */
iscb008       number(20,6)      ,/* 收銀機發票(三聯式) 免稅銷售額 */
iscb009       number(20,6)      ,/* 二聯式發票.收銀機發票(二聯式) 應稅銷售額 */
iscb010       number(20,6)      ,/* 二聯式發票.收銀機發票(二聯式) 應稅稅額 */
iscb011       number(20,6)      ,/* NO USE */
iscb012       number(20,6)      ,/* 二聯式發票.收銀機發票(二聯式) 免稅銷售額 */
iscb013       number(20,6)      ,/* 免用發票應稅銷售額 */
iscb014       number(20,6)      ,/* 免用發票稅額 */
iscb015       number(20,6)      ,/* 經海關出口零稅率銷售額 */
iscb016       number(20,6)      ,/* 免用發票免稅銷售額 */
iscb017       number(20,6)      ,/* 退回及折讓應稅銷售額 */
iscb018       number(20,6)      ,/* 退回及折讓應稅稅額 */
iscb019       number(20,6)      ,/* 退回及折讓零稅率銷售額 */
iscb020       number(20,6)      ,/* 退回及折讓免稅銷售額 */
iscb021       number(20,6)      ,/* 銷項一般應稅銷售額合計 */
iscb022       number(20,6)      ,/* 銷項一般應稅稅額合計 */
iscb023       number(20,6)      ,/* 銷項零稅率銷售額合計 */
iscb024       number(20,6)      ,/* 銷項免稅銷售額合計 */
iscb025       number(20,6)      ,/* 銷售額總合計 */
iscb026       number(20,6)      ,/* 銷售土地營業額合計 */
iscb027       number(20,6)      ,/* 銷售其他資產合計 */
iscb028       number(20,6)      ,/* 統一發票扣抵聯進貨及費用金額 */
iscb029       number(20,6)      ,/* 統一發票扣抵聯進貨及費用稅額 */
iscb030       number(20,6)      ,/* 統一發票扣抵聯固定資產金額 */
iscb031       number(20,6)      ,/* 統一發票扣抵聯固定資產稅額 */
iscb032       number(20,6)      ,/* 三聯式收銀機發票扣抵聯進貨及費用金額 */
iscb033       number(20,6)      ,/* 三聯式收銀機發票扣抵聯進貨及費用金額 */
iscb034       number(20,6)      ,/* 三聯式收銀機發票扣抵聯固定資產金額 */
iscb035       number(20,6)      ,/* 三聯式收銀機發票扣抵聯固定資產稅額 */
iscb036       number(20,6)      ,/* 載有稅額之其他憑證進貨及費用稅額 */
iscb037       number(20,6)      ,/* 載有稅額之其他憑證進貨及費用金額 */
iscb038       number(20,6)      ,/* 載有稅額之其他憑證固定資產金額 */
iscb039       number(20,6)      ,/* 載有稅額之其他憑證固定資產稅額 */
iscb040       number(20,6)      ,/* 退出折讓及海關退還溢繳稅額進貨及費用金額 */
iscb041       number(20,6)      ,/* 退出折讓及海關退還溢繳稅額進貨及費用稅額 */
iscb042       number(20,6)      ,/* 退出折讓及海關退還溢繳稅額固定資產金額 */
iscb043       number(20,6)      ,/* 退出折讓及海關退還溢繳稅額固定資產稅額 */
iscb044       number(20,6)      ,/* 進貨及費用金額合計 */
iscb045       number(20,6)      ,/* 進貨及費用稅額合計 */
iscb046       number(20,6)      ,/* 固定資產金額合計 */
iscb047       number(20,6)      ,/* 固定資產稅額合計 */
iscb048       number(20,6)      ,/* 進項總金額(含不得扣抵憑證及普通收據)進貨及費用 */
iscb049       number(20,6)      ,/* 進項總金額(含不得扣抵憑證及普通收據)固定資產 */
iscb050       number(20,6)      ,/* 不得扣抵比例 */
iscb051       number(20,6)      ,/* 得扣抵之進項稅額 */
iscb052       number(20,6)      ,/* 特種飲食業25%銷售額 */
iscb053       number(20,6)      ,/* 特種飲食業25%稅額 */
iscb054       number(20,6)      ,/* 特種飲食業15%銷售額 */
iscb055       number(20,6)      ,/* 特種飲食業15%稅額 */
iscb056       number(20,6)      ,/* 銀行保險信託投資業專屬本業收入 */
iscb057       number(20,6)      ,/* 銀行保險信託投資業專屬本業收入稅額 */
iscb058       number(20,6)      ,/* NO USE */
iscb059       number(20,6)      ,/* NO USE */
iscb060       number(20,6)      ,/* 再保收入1%銷售額 */
iscb061       number(20,6)      ,/* 再保收入1%稅額 */
iscb062       number(20,6)      ,/* 特種稅額免稅收入 */
iscb063       number(20,6)      ,/* 特種稅額退回及折讓銷售額 */
iscb064       number(20,6)      ,/* 特種稅額退回及折讓稅額 */
iscb065       number(20,6)      ,/* 特種稅額營業額合計 */
iscb066       number(20,6)      ,/* 特種稅額稅額合計 */
iscb073       number(20,6)      ,/* 進口免稅貨物 */
iscb074       number(20,6)      ,/* 購買國外勞務給付額 */
iscb075       number(20,6)      ,/* 購買國外勞務應比例計算之進項稅額 */
iscb076       number(20,6)      ,/* 購買國外勞務應納稅額 */
iscb078       number(20,6)      ,/* 海關代徵營業稅繳納證扣抵聯進貨及費用金額 */
iscb079       number(20,6)      ,/* 海關代徵營業稅繳納證扣抵聯進貨及費用稅額 */
iscb080       number(20,6)      ,/* 海關代徵營業稅繳納證扣抵聯固定資產金額 */
iscb081       number(20,6)      ,/* 海關代徵營業稅繳納證扣抵聯固定資產稅額 */
iscb082       number(20,6)      ,/* 免稅區銷售至境內其他區免開統一發票銷售額 */
iscb101       number(20,6)      ,/* 本期銷項稅額合計 */
iscb103       number(20,6)      ,/* 購買國外勞務應納稅額 */
iscb104       number(20,6)      ,/* 特種稅額計算之應納稅額 */
iscb105       number(20,6)      ,/* 中途歇業補徵應繳稅額 */
iscb106       number(20,6)      ,/* 應納稅額小計 */
iscb107       number(20,6)      ,/* 得扣抵進項稅額合計 */
iscb108       number(20,6)      ,/* 上期累積留抵稅額 */
iscb109       number(20,6)      ,/* 中途歇業應退稅額 */
iscb110       number(20,6)      ,/* 可扣抵稅額小計 */
iscb111       number(20,6)      ,/* 本期應實繳稅額 */
iscb112       number(20,6)      ,/* 本期申報留抵稅額 */
iscb113       number(20,6)      ,/* 得退稅限額合計 */
iscb114       number(20,6)      ,/* 本期應退稅額 */
iscb115       number(20,6)      ,/* 本期累積留抵稅額 */
iscbownid       varchar2(20)      ,/* 資料所有者 */
iscbowndp       varchar2(10)      ,/* 資料所屬部門 */
iscbcrtid       varchar2(20)      ,/* 資料建立者 */
iscbcrtdp       varchar2(10)      ,/* 資料建立部門 */
iscbcrtdt       timestamp(0)      ,/* 資料創建日 */
iscbmodid       varchar2(20)      ,/* 資料修改者 */
iscbmoddt       timestamp(0)      ,/* 最近修改日 */
iscbcnfid       varchar2(20)      ,/* 資料確認者 */
iscbcnfdt       timestamp(0)      ,/* 資料確認日 */
iscbpstid       varchar2(20)      ,/* 資料過帳者 */
iscbpstdt       timestamp(0)      ,/* 資料過帳日 */
iscbstus       varchar2(10)      ,/* 狀態碼 */
iscbud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
iscbud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
iscbud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
iscbud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
iscbud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
iscbud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
iscbud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
iscbud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
iscbud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
iscbud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
iscbud011       number(20,6)      ,/* 自定義欄位(數字)011 */
iscbud012       number(20,6)      ,/* 自定義欄位(數字)012 */
iscbud013       number(20,6)      ,/* 自定義欄位(數字)013 */
iscbud014       number(20,6)      ,/* 自定義欄位(數字)014 */
iscbud015       number(20,6)      ,/* 自定義欄位(數字)015 */
iscbud016       number(20,6)      ,/* 自定義欄位(數字)016 */
iscbud017       number(20,6)      ,/* 自定義欄位(數字)017 */
iscbud018       number(20,6)      ,/* 自定義欄位(數字)018 */
iscbud019       number(20,6)      ,/* 自定義欄位(數字)019 */
iscbud020       number(20,6)      ,/* 自定義欄位(數字)020 */
iscbud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
iscbud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
iscbud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
iscbud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
iscbud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
iscbud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
iscbud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
iscbud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
iscbud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
iscbud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
iscb084       number(20,6)      ,/* 銀行保險業經營銀行保險本業收入 */
iscb085       number(20,6)      /* 銀行保險業經營銀行保險本業收入稅額 */
);
alter table iscb_t add constraint iscb_pk primary key (iscbent,iscbcomp,iscbsite,iscb200,iscb201) enable validate;

create unique index iscb_pk on iscb_t (iscbent,iscbcomp,iscbsite,iscb200,iscb201);

grant select on iscb_t to tiptop;
grant update on iscb_t to tiptop;
grant delete on iscb_t to tiptop;
grant insert on iscb_t to tiptop;

exit;
