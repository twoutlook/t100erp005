/* 
================================================================================
檔案代號:glau_t
檔案名稱:傳票額外摘要資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table glau_t
(
glauent       number(5)      ,/* 企業編號 */
glauownid       varchar2(20)      ,/* 資料所有者 */
glauowndp       varchar2(10)      ,/* 資料所屬部門 */
glaucrtid       varchar2(20)      ,/* 資料建立者 */
glaucrtdp       varchar2(10)      ,/* 資料建立部門 */
glaucrtdt       timestamp(0)      ,/* 資料創建日 */
glaumodid       varchar2(20)      ,/* 資料修改者 */
glaumoddt       timestamp(0)      ,/* 最近修改日 */
glaustus       varchar2(10)      ,/* 狀態碼 */
glauld       varchar2(5)      ,/* 帳別(套)編號 */
glau001       varchar2(1)      ,/* 傳票性質 */
glau002       varchar2(20)      ,/* 傳票編號 */
glau003       number(10,0)      ,/* 項次 */
glau004       number(10,0)      ,/* 行序 */
glau005       varchar2(80)      ,/* 摘要 */
glauud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
glauud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
glauud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
glauud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
glauud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
glauud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
glauud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
glauud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
glauud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
glauud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
glauud011       number(20,6)      ,/* 自定義欄位(數字)011 */
glauud012       number(20,6)      ,/* 自定義欄位(數字)012 */
glauud013       number(20,6)      ,/* 自定義欄位(數字)013 */
glauud014       number(20,6)      ,/* 自定義欄位(數字)014 */
glauud015       number(20,6)      ,/* 自定義欄位(數字)015 */
glauud016       number(20,6)      ,/* 自定義欄位(數字)016 */
glauud017       number(20,6)      ,/* 自定義欄位(數字)017 */
glauud018       number(20,6)      ,/* 自定義欄位(數字)018 */
glauud019       number(20,6)      ,/* 自定義欄位(數字)019 */
glauud020       number(20,6)      ,/* 自定義欄位(數字)020 */
glauud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
glauud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
glauud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
glauud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
glauud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
glauud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
glauud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
glauud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
glauud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
glauud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table glau_t add constraint glau_pk primary key (glauent,glauld,glau001,glau002,glau003,glau004) enable validate;

create unique index glau_pk on glau_t (glauent,glauld,glau001,glau002,glau003,glau004);

grant select on glau_t to tiptop;
grant update on glau_t to tiptop;
grant delete on glau_t to tiptop;
grant insert on glau_t to tiptop;

exit;
