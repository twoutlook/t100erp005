/* 
================================================================================
檔案代號:glah_t
檔案名稱:傳票摘要彈性預設檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table glah_t
(
glahent       number(5)      ,/* 企業編號 */
glahownid       varchar2(20)      ,/* 資料所有者 */
glahowndp       varchar2(10)      ,/* 資料所屬部門 */
glahcrtid       varchar2(20)      ,/* 資料建立者 */
glahcrtdp       varchar2(10)      ,/* 資料建立部門 */
glahcrtdt       timestamp(0)      ,/* 資料創建日 */
glahmodid       varchar2(20)      ,/* 資料修改者 */
glahmoddt       timestamp(0)      ,/* 最近修改日 */
glahstus       varchar2(10)      ,/* 狀態碼 */
glahld       varchar2(5)      ,/* 帳別編號 */
glah001       varchar2(24)      ,/* 科目編號 */
glah002       varchar2(20)      ,/* 交易作業編號 */
glah003       varchar2(100)      ,/* 摘要設定值 */
glah004       varchar2(10)      ,/* 目的欄位 */
glahud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
glahud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
glahud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
glahud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
glahud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
glahud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
glahud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
glahud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
glahud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
glahud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
glahud011       number(20,6)      ,/* 自定義欄位(數字)011 */
glahud012       number(20,6)      ,/* 自定義欄位(數字)012 */
glahud013       number(20,6)      ,/* 自定義欄位(數字)013 */
glahud014       number(20,6)      ,/* 自定義欄位(數字)014 */
glahud015       number(20,6)      ,/* 自定義欄位(數字)015 */
glahud016       number(20,6)      ,/* 自定義欄位(數字)016 */
glahud017       number(20,6)      ,/* 自定義欄位(數字)017 */
glahud018       number(20,6)      ,/* 自定義欄位(數字)018 */
glahud019       number(20,6)      ,/* 自定義欄位(數字)019 */
glahud020       number(20,6)      ,/* 自定義欄位(數字)020 */
glahud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
glahud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
glahud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
glahud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
glahud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
glahud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
glahud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
glahud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
glahud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
glahud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table glah_t add constraint glah_pk primary key (glahent,glahld,glah001,glah002,glah004) enable validate;

create unique index glah_pk on glah_t (glahent,glahld,glah001,glah002,glah004);

grant select on glah_t to tiptop;
grant update on glah_t to tiptop;
grant delete on glah_t to tiptop;
grant insert on glah_t to tiptop;

exit;
