/* 
================================================================================
檔案代號:indl_t
檔案名稱:調撥多庫儲批明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table indl_t
(
indlent       number(5)      ,/* 企業代碼 */
indlsite       varchar2(10)      ,/* 營運據點 */
indlunit       varchar2(10)      ,/* 應用組織 */
indldocno       varchar2(20)      ,/* 調撥單號 */
indlseq       number(10,0)      ,/* 項次 */
indlseq1       number(10,0)      ,/* 項序 */
indl001       varchar2(40)      ,/* 商品條碼 */
indl002       varchar2(40)      ,/* 商品編號 */
indl003       varchar2(256)      ,/* 產品特徵 */
indl004       varchar2(10)      ,/* 包裝單位 */
indl005       varchar2(10)      ,/* 庫存單位 */
indl020       number(20,6)      ,/* 撥出件數 */
indl021       number(20,6)      ,/* 撥出數量 */
indl022       varchar2(10)      ,/* 撥出庫位 */
indl023       varchar2(10)      ,/* 撥出儲位 */
indl024       varchar2(30)      ,/* 撥出批號 */
indl030       number(20,6)      ,/* 撥入件數 */
indl031       number(20,6)      ,/* 撥入數量 */
indl032       varchar2(10)      ,/* 撥入庫位 */
indl033       varchar2(10)      ,/* 撥入儲位 */
indl034       varchar2(30)      ,/* 撥入批號 */
indl101       varchar2(30)      ,/* 庫存管理特徵 */
indlud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
indlud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
indlud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
indlud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
indlud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
indlud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
indlud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
indlud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
indlud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
indlud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
indlud011       number(20,6)      ,/* 自定義欄位(數字)011 */
indlud012       number(20,6)      ,/* 自定義欄位(數字)012 */
indlud013       number(20,6)      ,/* 自定義欄位(數字)013 */
indlud014       number(20,6)      ,/* 自定義欄位(數字)014 */
indlud015       number(20,6)      ,/* 自定義欄位(數字)015 */
indlud016       number(20,6)      ,/* 自定義欄位(數字)016 */
indlud017       number(20,6)      ,/* 自定義欄位(數字)017 */
indlud018       number(20,6)      ,/* 自定義欄位(數字)018 */
indlud019       number(20,6)      ,/* 自定義欄位(數字)019 */
indlud020       number(20,6)      ,/* 自定義欄位(數字)020 */
indlud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
indlud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
indlud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
indlud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
indlud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
indlud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
indlud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
indlud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
indlud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
indlud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
indl102       number(20,6)      ,/* 成本單價 */
indl103       number(20,6)      /* 成本金額 */
);
alter table indl_t add constraint indl_pk primary key (indlent,indldocno,indlseq,indlseq1) enable validate;

create unique index indl_pk on indl_t (indlent,indldocno,indlseq,indlseq1);

grant select on indl_t to tiptop;
grant update on indl_t to tiptop;
grant delete on indl_t to tiptop;
grant insert on indl_t to tiptop;

exit;
