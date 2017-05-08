/* 
================================================================================
檔案代號:glbe_t
檔案名稱:間接法資料設定檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table glbe_t
(
glbeent       number(5)      ,/* 企業編號 */
glbeownid       varchar2(20)      ,/* 資料所有者 */
glbeowndp       varchar2(10)      ,/* 資料所屬部門 */
glbecrtid       varchar2(20)      ,/* 資料建立者 */
glbecrtdp       varchar2(10)      ,/* 資料建立部門 */
glbecrtdt       timestamp(0)      ,/* 資料創建日 */
glbemodid       varchar2(20)      ,/* 資料修改者 */
glbemoddt       timestamp(0)      ,/* 最近修改日 */
glbestus       varchar2(10)      ,/* 狀態碼 */
glbeld       varchar2(5)      ,/* 帳別 */
glbe001       varchar2(10)      ,/* 群組編號 */
glbe002       varchar2(24)      ,/* 科目編號 */
glbe003       varchar2(1)      ,/* 加減項 */
glbe004       varchar2(1)      ,/* 異動別 */
glbeud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
glbeud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
glbeud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
glbeud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
glbeud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
glbeud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
glbeud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
glbeud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
glbeud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
glbeud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
glbeud011       number(20,6)      ,/* 自定義欄位(數字)011 */
glbeud012       number(20,6)      ,/* 自定義欄位(數字)012 */
glbeud013       number(20,6)      ,/* 自定義欄位(數字)013 */
glbeud014       number(20,6)      ,/* 自定義欄位(數字)014 */
glbeud015       number(20,6)      ,/* 自定義欄位(數字)015 */
glbeud016       number(20,6)      ,/* 自定義欄位(數字)016 */
glbeud017       number(20,6)      ,/* 自定義欄位(數字)017 */
glbeud018       number(20,6)      ,/* 自定義欄位(數字)018 */
glbeud019       number(20,6)      ,/* 自定義欄位(數字)019 */
glbeud020       number(20,6)      ,/* 自定義欄位(數字)020 */
glbeud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
glbeud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
glbeud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
glbeud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
glbeud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
glbeud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
glbeud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
glbeud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
glbeud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
glbeud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table glbe_t add constraint glbe_pk primary key (glbeent,glbeld,glbe001,glbe002) enable validate;

create unique index glbe_pk on glbe_t (glbeent,glbeld,glbe001,glbe002);

grant select on glbe_t to tiptop;
grant update on glbe_t to tiptop;
grant delete on glbe_t to tiptop;
grant insert on glbe_t to tiptop;

exit;
