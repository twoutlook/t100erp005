/* 
================================================================================
檔案代號:gzxe_t
檔案名稱:使用者對部門配置檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table gzxe_t
(
gzxeent       number(5)      ,/* 企業編號 */
gzxeownid       varchar2(20)      ,/* 資料所有者 */
gzxeowndp       varchar2(10)      ,/* 資料所屬部門 */
gzxecrtid       varchar2(20)      ,/* 資料建立者 */
gzxecrtdp       varchar2(10)      ,/* 資料建立部門 */
gzxecrtdt       timestamp(0)      ,/* 資料創建日 */
gzxemodid       varchar2(20)      ,/* 資料修改者 */
gzxemoddt       timestamp(0)      ,/* 最近修改日 */
gzxestus       varchar2(10)      ,/* 狀態碼 */
gzxe001       varchar2(20)      ,/* 用戶編號 */
gzxe002       varchar2(10)      ,/* 部門組織編號 */
gzxe003       date      ,/* 生效日期 */
gzxe004       date      ,/* 失效日期 */
gzxe005       varchar2(1)      ,/* 允許下展 */
gzxeud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
gzxeud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
gzxeud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
gzxeud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
gzxeud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
gzxeud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
gzxeud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
gzxeud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
gzxeud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
gzxeud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
gzxeud011       number(20,6)      ,/* 自定義欄位(數字)011 */
gzxeud012       number(20,6)      ,/* 自定義欄位(數字)012 */
gzxeud013       number(20,6)      ,/* 自定義欄位(數字)013 */
gzxeud014       number(20,6)      ,/* 自定義欄位(數字)014 */
gzxeud015       number(20,6)      ,/* 自定義欄位(數字)015 */
gzxeud016       number(20,6)      ,/* 自定義欄位(數字)016 */
gzxeud017       number(20,6)      ,/* 自定義欄位(數字)017 */
gzxeud018       number(20,6)      ,/* 自定義欄位(數字)018 */
gzxeud019       number(20,6)      ,/* 自定義欄位(數字)019 */
gzxeud020       number(20,6)      ,/* 自定義欄位(數字)020 */
gzxeud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
gzxeud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
gzxeud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
gzxeud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
gzxeud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
gzxeud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
gzxeud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
gzxeud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
gzxeud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
gzxeud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table gzxe_t add constraint gzxe_pk primary key (gzxeent,gzxe001,gzxe002) enable validate;

create unique index gzxe_pk on gzxe_t (gzxeent,gzxe001,gzxe002);

grant select on gzxe_t to tiptop;
grant update on gzxe_t to tiptop;
grant delete on gzxe_t to tiptop;
grant insert on gzxe_t to tiptop;

exit;
