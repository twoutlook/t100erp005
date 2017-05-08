/* 
================================================================================
檔案代號:inff_t
檔案名稱:商品貨架關係表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table inff_t
(
inffent       number(5)      ,/* 企業編號 */
inffsite       varchar2(10)      ,/* 營運據點 */
inff001       varchar2(40)      ,/* 商品編碼 */
inff002       varchar2(40)      ,/* 商品條碼 */
inff003       varchar2(256)      ,/* 商品特征 */
inff004       varchar2(10)      ,/* 庫存單位 */
inff005       varchar2(10)      ,/* 貨架編號 */
inff006       varchar2(10)      ,/* 貨架類型 */
inff007       number(5,0)      ,/* 開始層 */
inff008       number(5,0)      ,/* 結束層 */
inff009       number(5,0)      ,/* 開始列 */
inff010       number(5,0)      ,/* 結束列 */
inff011       number(5,0)      ,/* 排面數量 */
inff012       number(5,0)      ,/* 最小陳列量 */
inff013       number(5,0)      ,/* 最大陳列量 */
inff014       number(5,0)      ,/* 最小庫存量 */
inff015       number(5,0)      ,/* 單層層板陳列數 */
inff016       number(5,0)      ,/* 單層層板層數 */
inffud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
inffud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
inffud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
inffud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
inffud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
inffud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
inffud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
inffud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
inffud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
inffud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
inffud011       number(20,6)      ,/* 自定義欄位(數字)011 */
inffud012       number(20,6)      ,/* 自定義欄位(數字)012 */
inffud013       number(20,6)      ,/* 自定義欄位(數字)013 */
inffud014       number(20,6)      ,/* 自定義欄位(數字)014 */
inffud015       number(20,6)      ,/* 自定義欄位(數字)015 */
inffud016       number(20,6)      ,/* 自定義欄位(數字)016 */
inffud017       number(20,6)      ,/* 自定義欄位(數字)017 */
inffud018       number(20,6)      ,/* 自定義欄位(數字)018 */
inffud019       number(20,6)      ,/* 自定義欄位(數字)019 */
inffud020       number(20,6)      ,/* 自定義欄位(數字)020 */
inffud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
inffud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
inffud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
inffud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
inffud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
inffud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
inffud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
inffud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
inffud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
inffud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table inff_t add constraint inff_pk primary key (inffent,inffsite,inff001,inff006) enable validate;

create unique index inff_pk on inff_t (inffent,inffsite,inff001,inff006);

grant select on inff_t to tiptop;
grant update on inff_t to tiptop;
grant delete on inff_t to tiptop;
grant insert on inff_t to tiptop;

exit;
