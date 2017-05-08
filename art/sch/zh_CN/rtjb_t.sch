/* 
================================================================================
檔案代號:rtjb_t
檔案名稱:銷售整合商品明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:Y
============.========================.==========================================
 */
create table rtjb_t
(
rtjbent       number(5)      ,/* 企業編號 */
rtjbsite       varchar2(10)      ,/* 營運據點 */
rtjbunit       varchar2(10)      ,/* 應用組織 */
rtjborga       varchar2(10)      ,/* 帳務組織 */
rtjbdocno       varchar2(20)      ,/* 單據編號 */
rtjbseq       number(10,0)      ,/* 項次 */
rtjb001       varchar2(20)      ,/* 來源單號 */
rtjb002       number(10,0)      ,/* 來源單號項次 */
rtjb003       varchar2(40)      ,/* 商品條碼 */
rtjb004       varchar2(40)      ,/* 商品編號 */
rtjb005       varchar2(256)      ,/* 特徵碼 */
rtjb006       varchar2(10)      ,/* 稅別編號 */
rtjb007       varchar2(1)      ,/* 銷售開立發票 */
rtjb008       number(20,6)      ,/* 標準售價 */
rtjb009       number(20,6)      ,/* 促銷售價 */
rtjb010       number(20,6)      ,/* 交易售價 */
rtjb011       number(20,6)      ,/* 成本售價 */
rtjb012       number(20,6)      ,/* 銷售數量 */
rtjb013       varchar2(10)      ,/* 銷售單位 */
rtjb014       number(20,6)      ,/* 庫存數量 */
rtjb015       varchar2(10)      ,/* 庫存單位 */
rtjb016       number(20,6)      ,/* 銷售庫存單位換算率 */
rtjb017       number(20,6)      ,/* 計價數量 */
rtjb018       varchar2(10)      ,/* 計價單位 */
rtjb019       number(20,6)      ,/* 銷售計價單位換算率 */
rtjb020       number(20,6)      ,/* 折價金額 */
rtjb021       number(20,6)      ,/* 應收金額 */
rtjb022       number(20,6)      ,/* 未稅金額 */
rtjb023       number(20,6)      ,/* 成本金額 */
rtjb024       varchar2(10)      ,/* 理由碼 */
rtjb025       varchar2(10)      ,/* 庫區 */
rtjb026       varchar2(10)      ,/* 儲位 */
rtjb027       varchar2(30)      ,/* 批號 */
rtjb028       varchar2(20)      ,/* 專櫃編號 */
rtjb029       number(15,3)      ,/* 分攤積點 */
rtjb030       number(10,0)      ,/* 卡券銷售明細對應項次 */
rtjb031       number(20,6)      ,/* 本幣應收金額 */
rtjbud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
rtjbud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
rtjbud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
rtjbud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
rtjbud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
rtjbud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
rtjbud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
rtjbud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
rtjbud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
rtjbud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
rtjbud011       number(20,6)      ,/* 自定義欄位(數字)011 */
rtjbud012       number(20,6)      ,/* 自定義欄位(數字)012 */
rtjbud013       number(20,6)      ,/* 自定義欄位(數字)013 */
rtjbud014       number(20,6)      ,/* 自定義欄位(數字)014 */
rtjbud015       number(20,6)      ,/* 自定義欄位(數字)015 */
rtjbud016       number(20,6)      ,/* 自定義欄位(數字)016 */
rtjbud017       number(20,6)      ,/* 自定義欄位(數字)017 */
rtjbud018       number(20,6)      ,/* 自定義欄位(數字)018 */
rtjbud019       number(20,6)      ,/* 自定義欄位(數字)019 */
rtjbud020       number(20,6)      ,/* 自定義欄位(數字)020 */
rtjbud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
rtjbud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
rtjbud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
rtjbud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
rtjbud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
rtjbud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
rtjbud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
rtjbud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
rtjbud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
rtjbud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
rtjb032       varchar2(30)      ,/* 庫存管理特徵 */
rtjb033       varchar2(10)      ,/* 營業員 */
rtjb034       varchar2(40)      ,/* 掃描碼 */
rtjb035       varchar2(10)      ,/* 交易類型 */
rtjb036       varchar2(10)      ,/* 商品屬性 */
rtjb037       number(10,0)      ,/* 捆綁條碼項次 */
rtjb038       number(20,6)      ,/* 結算扣率 */
rtjb039       varchar2(1)      ,/* 贈品否 */
rtjb040       varchar2(10)      ,/* 卡種/券種編號 */
rtjb041       varchar2(30)      /* 卡號/券號 */
);
alter table rtjb_t add constraint rtjb_pk primary key (rtjbent,rtjbdocno,rtjbseq) enable validate;

create  index rtjb_n01 on rtjb_t (rtjbent,rtjbdocno,rtjb004,rtjb012,rtjb013,rtjb025,rtjb028);
create unique index rtjb_pk on rtjb_t (rtjbent,rtjbdocno,rtjbseq);

grant select on rtjb_t to tiptop;
grant update on rtjb_t to tiptop;
grant delete on rtjb_t to tiptop;
grant insert on rtjb_t to tiptop;

exit;
