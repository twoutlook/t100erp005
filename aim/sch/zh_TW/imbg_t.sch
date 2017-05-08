/* 
================================================================================
檔案代號:imbg_t
檔案名稱:料件申請料號據點財務檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table imbg_t
(
imbgent       number(5)      ,/* 企業編號 */
imbgsite       varchar2(10)      ,/* 營運據點 */
imbgdocno       varchar2(20)      ,/* 申請單號 */
imbg001       varchar2(40)      ,/* 料件編號 */
imbg011       varchar2(10)      ,/* 財務分群 */
imbg012       varchar2(24)      ,/* 採購入庫借方會科 */
imbg013       varchar2(40)      ,/* 成本料號 */
imbg014       varchar2(10)      ,/* 成本單位 */
imbg015       varchar2(10)      ,/* 成本計價方式 */
imbgownid       varchar2(20)      ,/* 資料所屬者 */
imbgowndp       varchar2(10)      ,/* 資料所有部門 */
imbgcrtid       varchar2(20)      ,/* 資料建立者 */
imbgcrtdp       varchar2(10)      ,/* 資料建立部門 */
imbgcrtdt       timestamp(0)      ,/* 資料創建日 */
imbgmodid       varchar2(20)      ,/* 資料修改者 */
imbgmoddt       timestamp(0)      ,/* 最近修改日 */
imbgcnfid       varchar2(20)      ,/* 資料確認者 */
imbgcnfdt       timestamp(0)      ,/* 資料確認日 */
imbgstus       varchar2(10)      ,/* 狀態碼 */
imbgud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
imbgud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
imbgud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
imbgud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
imbgud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
imbgud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
imbgud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
imbgud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
imbgud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
imbgud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
imbgud011       number(20,6)      ,/* 自定義欄位(數字)011 */
imbgud012       number(20,6)      ,/* 自定義欄位(數字)012 */
imbgud013       number(20,6)      ,/* 自定義欄位(數字)013 */
imbgud014       number(20,6)      ,/* 自定義欄位(數字)014 */
imbgud015       number(20,6)      ,/* 自定義欄位(數字)015 */
imbgud016       number(20,6)      ,/* 自定義欄位(數字)016 */
imbgud017       number(20,6)      ,/* 自定義欄位(數字)017 */
imbgud018       number(20,6)      ,/* 自定義欄位(數字)018 */
imbgud019       number(20,6)      ,/* 自定義欄位(數字)019 */
imbgud020       number(20,6)      ,/* 自定義欄位(數字)020 */
imbgud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
imbgud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
imbgud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
imbgud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
imbgud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
imbgud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
imbgud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
imbgud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
imbgud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
imbgud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
imbg024       varchar2(10)      /* 材料類型 */
);
alter table imbg_t add constraint imbg_pk primary key (imbgent,imbgsite,imbgdocno) enable validate;

create  index imbg_01 on imbg_t (imbg001);
create  index imbg_02 on imbg_t (imbg011);
create unique index imbg_pk on imbg_t (imbgent,imbgsite,imbgdocno);

grant select on imbg_t to tiptop;
grant update on imbg_t to tiptop;
grant delete on imbg_t to tiptop;
grant insert on imbg_t to tiptop;

exit;
