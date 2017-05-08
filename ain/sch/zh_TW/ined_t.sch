/* 
================================================================================
檔案代號:ined_t
檔案名稱:盤點計劃進度配置資料表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table ined_t
(
inedent       number(5)      ,/* 企業編號 */
inedunit       varchar2(10)      ,/* 應用組織 */
inedsite       varchar2(10)      ,/* 營運據點 */
ined001       varchar2(20)      ,/* 盤點計劃 */
ined002       date      ,/* 盤點日期 */
ined003       varchar2(10)      ,/* 盤點作業 */
ined004       varchar2(1)      ,/* 啟用流程 */
ined005       varchar2(1)      ,/* 進度狀況 */
ined006       varchar2(20)      ,/* 操作人員 */
ined007       date      ,/* 操作日期 */
ined008       varchar2(8)      ,/* 操作時間 */
inedownid       varchar2(20)      ,/* 資料所有者 */
inedowndp       varchar2(10)      ,/* 資料所屬部門 */
inedcrtid       varchar2(20)      ,/* 資料建立者 */
inedcrtdp       varchar2(10)      ,/* 資料建立部門 */
inedcrtdt       timestamp(0)      ,/* 資料創建日 */
inedmodid       varchar2(20)      ,/* 資料修改者 */
inedmoddt       timestamp(0)      ,/* 最近修改日 */
inedud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
inedud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
inedud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
inedud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
inedud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
inedud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
inedud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
inedud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
inedud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
inedud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
inedud011       number(20,6)      ,/* 自定義欄位(數字)011 */
inedud012       number(20,6)      ,/* 自定義欄位(數字)012 */
inedud013       number(20,6)      ,/* 自定義欄位(數字)013 */
inedud014       number(20,6)      ,/* 自定義欄位(數字)014 */
inedud015       number(20,6)      ,/* 自定義欄位(數字)015 */
inedud016       number(20,6)      ,/* 自定義欄位(數字)016 */
inedud017       number(20,6)      ,/* 自定義欄位(數字)017 */
inedud018       number(20,6)      ,/* 自定義欄位(數字)018 */
inedud019       number(20,6)      ,/* 自定義欄位(數字)019 */
inedud020       number(20,6)      ,/* 自定義欄位(數字)020 */
inedud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
inedud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
inedud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
inedud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
inedud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
inedud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
inedud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
inedud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
inedud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
inedud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table ined_t add constraint ined_pk primary key (inedent,inedsite,ined001,ined003) enable validate;

create unique index ined_pk on ined_t (inedent,inedsite,ined001,ined003);

grant select on ined_t to tiptop;
grant update on ined_t to tiptop;
grant delete on ined_t to tiptop;
grant insert on ined_t to tiptop;

exit;
