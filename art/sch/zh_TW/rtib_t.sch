/* 
================================================================================
檔案代號:rtib_t
檔案名稱:銷售交易商品明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table rtib_t
(
rtibent       number(5)      ,/* 企業編號 */
rtibsite       varchar2(10)      ,/* 營運據點 */
rtibunit       varchar2(10)      ,/* 應用組織 */
rtiborga       varchar2(10)      ,/* 帳務組織 */
rtibdocno       varchar2(20)      ,/* 單據編號 */
rtibseq       number(10,0)      ,/* 項次 */
rtib001       varchar2(20)      ,/* 來源單號 */
rtib002       number(10,0)      ,/* 來源單號項次 */
rtib003       varchar2(40)      ,/* 商品條碼 */
rtib004       varchar2(40)      ,/* 商品編號 */
rtib005       varchar2(256)      ,/* 特徵碼 */
rtib006       varchar2(10)      ,/* 稅別編號 */
rtib007       varchar2(1)      ,/* 銷售開立發票 */
rtib008       number(20,6)      ,/* 標準售價 */
rtib009       number(20,6)      ,/* 促銷售價 */
rtib010       number(20,6)      ,/* 交易售價 */
rtib011       number(20,6)      ,/* 成本售價 */
rtib012       number(20,6)      ,/* 銷售數量 */
rtib013       varchar2(10)      ,/* 銷售單位 */
rtib014       number(20,6)      ,/* 庫存數量 */
rtib015       varchar2(10)      ,/* 庫存單位 */
rtib016       number(20,6)      ,/* 銷售庫存單位換算率 */
rtib017       number(20,6)      ,/* 計價數量 */
rtib018       varchar2(10)      ,/* 計價單位 */
rtib019       number(20,6)      ,/* 銷售計價單位換算率 */
rtib020       number(20,6)      ,/* 折價金額 */
rtib021       number(20,6)      ,/* 應收金額 */
rtib022       number(20,6)      ,/* 未稅金額 */
rtib023       number(20,6)      ,/* 成本金額 */
rtib024       varchar2(10)      ,/* 理由碼 */
rtib025       varchar2(10)      ,/* 庫區 */
rtib026       varchar2(10)      ,/* 儲位 */
rtib027       varchar2(30)      ,/* 批號 */
rtib028       varchar2(20)      ,/* 專櫃編號 */
rtib029       number(15,3)      ,/* 分攤積點 */
rtib030       number(10,0)      ,/* 卡券銷售明細對應項次 */
rtib031       number(20,6)      ,/* 本幣應收金額 */
rtibud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
rtibud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
rtibud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
rtibud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
rtibud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
rtibud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
rtibud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
rtibud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
rtibud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
rtibud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
rtibud011       number(20,6)      ,/* 自定義欄位(數字)011 */
rtibud012       number(20,6)      ,/* 自定義欄位(數字)012 */
rtibud013       number(20,6)      ,/* 自定義欄位(數字)013 */
rtibud014       number(20,6)      ,/* 自定義欄位(數字)014 */
rtibud015       number(20,6)      ,/* 自定義欄位(數字)015 */
rtibud016       number(20,6)      ,/* 自定義欄位(數字)016 */
rtibud017       number(20,6)      ,/* 自定義欄位(數字)017 */
rtibud018       number(20,6)      ,/* 自定義欄位(數字)018 */
rtibud019       number(20,6)      ,/* 自定義欄位(數字)019 */
rtibud020       number(20,6)      ,/* 自定義欄位(數字)020 */
rtibud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
rtibud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
rtibud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
rtibud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
rtibud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
rtibud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
rtibud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
rtibud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
rtibud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
rtibud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
rtib032       varchar2(30)      ,/* 庫存管理特徵 */
rtib033       varchar2(10)      ,/* 營業員 */
rtib034       varchar2(40)      ,/* 掃描碼 */
rtib035       varchar2(10)      ,/* 交易類型 */
rtib036       varchar2(10)      ,/* 商品屬性 */
rtib037       number(10,0)      ,/* 捆綁條碼項次 */
rtib038       number(20,6)      ,/* 結算扣率 */
rtib039       varchar2(1)      ,/* 贈品否 */
rtib040       varchar2(10)      ,/* 卡種/券種編號 */
rtib041       varchar2(30)      ,/* 卡號/券號 */
rtib101       varchar2(1)      ,/* 退貨退回商品(租賃) */
rtib102       varchar2(10)      ,/* 產品品類(租賃) */
rtib103       varchar2(10)      ,/* 品牌(租賃) */
rtib104       varchar2(10)      ,/* 商戶編號(租賃) */
rtib105       varchar2(20)      ,/* 合約編號(租賃) */
rtib106       number(22,2)      ,/* 單位兌換積分 */
rtib107       number(22,2)      ,/* 促銷單位兌換積分 */
rtib108       number(22,2)      ,/* 總兌換積分 */
rtib042       varchar2(1)      ,/* 退貨方式 */
rtib043       varchar2(20)      ,/* 發票編號 */
rtib044       varchar2(20)      ,/* 發票號碼 */
rtib109       number(20,6)      /* 返現金額 */
);
alter table rtib_t add constraint rtib_pk primary key (rtibent,rtibdocno,rtibseq) enable validate;

create unique index rtib_pk on rtib_t (rtibent,rtibdocno,rtibseq);

grant select on rtib_t to tiptop;
grant update on rtib_t to tiptop;
grant delete on rtib_t to tiptop;
grant insert on rtib_t to tiptop;

exit;
