/* 
================================================================================
檔案代號:crad_t
檔案名稱:業務員工作日報資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:Y
============.========================.==========================================
 */
create table crad_t
(
cradent       number(5)      ,/* 企業編號 */
cradunit       varchar2(10)      ,/* 應用組織 */
crad001       varchar2(20)      ,/* 業務人員 */
crad002       date      ,/* 日報日期 */
crad003       varchar2(10)      ,/* 潛客編號 */
crad004       number(20,6)      ,/* 成交機率 */
crad005       number(10,0)      ,/* 項次 */
crad006       varchar2(10)      ,/* 日報類型 */
crad007       varchar2(255)      ,/* 日報內容 */
cradownid       varchar2(20)      ,/* 資料所有者 */
cradowndp       varchar2(10)      ,/* 資料所屬部門 */
cradcrtid       varchar2(20)      ,/* 資料建立者 */
cradcrtdp       varchar2(10)      ,/* 資料建立部門 */
cradcrtdt       timestamp(0)      ,/* 資料創建日 */
cradmodid       varchar2(20)      ,/* 資料修改者 */
cradmoddt       timestamp(0)      ,/* 最近修改日 */
cradcnfid       varchar2(20)      ,/* 資料確認者 */
cradcnfdt       timestamp(0)      ,/* 資料確認日 */
cradstus       varchar2(10)      ,/* 狀態碼 */
cradud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
cradud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
cradud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
cradud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
cradud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
cradud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
cradud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
cradud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
cradud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
cradud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
cradud011       number(20,6)      ,/* 自定義欄位(數字)011 */
cradud012       number(20,6)      ,/* 自定義欄位(數字)012 */
cradud013       number(20,6)      ,/* 自定義欄位(數字)013 */
cradud014       number(20,6)      ,/* 自定義欄位(數字)014 */
cradud015       number(20,6)      ,/* 自定義欄位(數字)015 */
cradud016       number(20,6)      ,/* 自定義欄位(數字)016 */
cradud017       number(20,6)      ,/* 自定義欄位(數字)017 */
cradud018       number(20,6)      ,/* 自定義欄位(數字)018 */
cradud019       number(20,6)      ,/* 自定義欄位(數字)019 */
cradud020       number(20,6)      ,/* 自定義欄位(數字)020 */
cradud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
cradud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
cradud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
cradud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
cradud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
cradud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
cradud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
cradud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
cradud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
cradud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table crad_t add constraint crad_pk primary key (cradent,crad001,crad002,crad003,crad005) enable validate;

create unique index crad_pk on crad_t (cradent,crad001,crad002,crad003,crad005);

grant select on crad_t to tiptop;
grant update on crad_t to tiptop;
grant delete on crad_t to tiptop;
grant insert on crad_t to tiptop;

exit;
