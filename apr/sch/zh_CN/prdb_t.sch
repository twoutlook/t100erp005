/* 
================================================================================
檔案代號:prdb_t
檔案名稱:促銷規則申請對象主檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table prdb_t
(
prdbent       number(5)      ,/* 企業編號 */
prdbunit       varchar2(10)      ,/* 應用組織 */
prdbsite       varchar2(10)      ,/* 營運據點 */
prdbdocno       varchar2(20)      ,/* 促銷申請單號 */
prdb001       varchar2(20)      ,/* 規則編號 */
prdb002       number(10,0)      ,/* 組別 */
prdb003       varchar2(10)      ,/* 對象類別 */
prdb004       number(10,0)      ,/* 條件組別 */
prdb005       number(20,6)      ,/* 促銷值 */
prdbacti       varchar2(10)      ,/* 有效否 */
prdbud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
prdbud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
prdbud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
prdbud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
prdbud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
prdbud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
prdbud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
prdbud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
prdbud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
prdbud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
prdbud011       number(20,6)      ,/* 自定義欄位(數字)011 */
prdbud012       number(20,6)      ,/* 自定義欄位(數字)012 */
prdbud013       number(20,6)      ,/* 自定義欄位(數字)013 */
prdbud014       number(20,6)      ,/* 自定義欄位(數字)014 */
prdbud015       number(20,6)      ,/* 自定義欄位(數字)015 */
prdbud016       number(20,6)      ,/* 自定義欄位(數字)016 */
prdbud017       number(20,6)      ,/* 自定義欄位(數字)017 */
prdbud018       number(20,6)      ,/* 自定義欄位(數字)018 */
prdbud019       number(20,6)      ,/* 自定義欄位(數字)019 */
prdbud020       number(20,6)      ,/* 自定義欄位(數字)020 */
prdbud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
prdbud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
prdbud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
prdbud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
prdbud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
prdbud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
prdbud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
prdbud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
prdbud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
prdbud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
prdb006       varchar2(1)      ,/* 積分優惠 */
prdb007       number(15,3)      ,/* 積分基準 */
prdb008       number(15,3)      ,/* 單位積分 */
prdb009       number(15,3)      ,/* 加送積分 */
prdb010       number(5,0)      ,/* 會員達成次數限制 */
prdb011       number(5,0)      ,/* 總會員達成次數限制 */
prdb012       number(20,6)      ,/* 基數 */
prdb013       number(20,6)      ,/* 倍數 */
prdb014       number(10,0)      /* 對象幅度 */
);
alter table prdb_t add constraint prdb_pk primary key (prdbent,prdbdocno,prdb002,prdb004) enable validate;

create unique index prdb_pk on prdb_t (prdbent,prdbdocno,prdb002,prdb004);

grant select on prdb_t to tiptop;
grant update on prdb_t to tiptop;
grant delete on prdb_t to tiptop;
grant insert on prdb_t to tiptop;

exit;
