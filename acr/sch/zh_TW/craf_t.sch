/* 
================================================================================
檔案代號:craf_t
檔案名稱:潛在客戶競爭廠商資料檔案
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table craf_t
(
crafent       number(5)      ,/* 企業編號 */
crafunit       varchar2(10)      ,/* 應用組織 */
craf001       varchar2(10)      ,/* 潛在客戶編號 */
craf002       number(10,0)      ,/* 序號 */
craf003       varchar2(10)      ,/* 競爭廠商編號 */
craf004       date      ,/* 日期 */
craf005       varchar2(20)      ,/* 業務員 */
craf006       varchar2(4000)      ,/* 競爭過程 */
craf007       varchar2(4000)      ,/* 優勢 */
craf008       varchar2(4000)      ,/* 劣勢 */
crafstus       varchar2(10)      ,/* 資料狀態代碼 */
crafownid       varchar2(20)      ,/* 資料所有者 */
crafowndp       varchar2(10)      ,/* 資料所屬部門 */
crafcrtid       varchar2(20)      ,/* 資料建立者 */
crafcrtdp       varchar2(10)      ,/* 資料建立部門 */
crafcrtdt       timestamp(0)      ,/* 資料創建日 */
crafmodid       varchar2(20)      ,/* 資料修改者 */
crafmoddt       timestamp(0)      ,/* 最近修改日 */
crafcnfid       varchar2(20)      ,/* 資料確認者 */
crafcnfdt       timestamp(0)      ,/* 資料確認日 */
crafud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
crafud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
crafud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
crafud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
crafud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
crafud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
crafud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
crafud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
crafud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
crafud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
crafud011       number(20,6)      ,/* 自定義欄位(數字)011 */
crafud012       number(20,6)      ,/* 自定義欄位(數字)012 */
crafud013       number(20,6)      ,/* 自定義欄位(數字)013 */
crafud014       number(20,6)      ,/* 自定義欄位(數字)014 */
crafud015       number(20,6)      ,/* 自定義欄位(數字)015 */
crafud016       number(20,6)      ,/* 自定義欄位(數字)016 */
crafud017       number(20,6)      ,/* 自定義欄位(數字)017 */
crafud018       number(20,6)      ,/* 自定義欄位(數字)018 */
crafud019       number(20,6)      ,/* 自定義欄位(數字)019 */
crafud020       number(20,6)      ,/* 自定義欄位(數字)020 */
crafud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
crafud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
crafud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
crafud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
crafud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
crafud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
crafud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
crafud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
crafud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
crafud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table craf_t add constraint craf_pk primary key (crafent,craf001,craf003) enable validate;

create unique index craf_pk on craf_t (crafent,craf001,craf003);

grant select on craf_t to tiptop;
grant update on craf_t to tiptop;
grant delete on craf_t to tiptop;
grant insert on craf_t to tiptop;

exit;
