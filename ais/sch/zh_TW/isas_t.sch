/* 
================================================================================
檔案代號:isas_t
檔案名稱:發票簿調撥記錄檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table isas_t
(
isasent       number(5)      ,/* 企業編碼 */
isascomp       varchar2(10)      ,/* 法人編號 */
isassite       varchar2(10)      ,/* 營運據點 */
isas001       varchar2(10)      ,/* 發票簿號 */
isas002       date      ,/* 生效日期 */
isas003       date      ,/* 失效日期 */
isas004       varchar2(2)      ,/* 發票類型 */
isas005       varchar2(20)      ,/* 發票字軌 */
isas006       varchar2(20)      ,/* 發票代碼 */
isas007       varchar2(20)      ,/* 起始號碼 */
isas008       varchar2(20)      ,/* 結束號碼 */
isas009       number(10,0)      ,/* 發票張數 */
isas010       number(5,0)      ,/* 已開立張數 */
isas011       varchar2(10)      ,/* 撥入營運據點 */
isas012       varchar2(20)      ,/* 撥入起始號碼 */
isas013       varchar2(20)      ,/* 撥入結束號碼 */
isas014       varchar2(10)      ,/* 撥入簿號 */
isasstus       varchar2(1)      ,/* 狀態碼 */
isasud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
isasud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
isasud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
isasud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
isasud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
isasud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
isasud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
isasud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
isasud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
isasud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
isasud011       number(20,6)      ,/* 自定義欄位(數字)011 */
isasud012       number(20,6)      ,/* 自定義欄位(數字)012 */
isasud013       number(20,6)      ,/* 自定義欄位(數字)013 */
isasud014       number(20,6)      ,/* 自定義欄位(數字)014 */
isasud015       number(20,6)      ,/* 自定義欄位(數字)015 */
isasud016       number(20,6)      ,/* 自定義欄位(數字)016 */
isasud017       number(20,6)      ,/* 自定義欄位(數字)017 */
isasud018       number(20,6)      ,/* 自定義欄位(數字)018 */
isasud019       number(20,6)      ,/* 自定義欄位(數字)019 */
isasud020       number(20,6)      ,/* 自定義欄位(數字)020 */
isasud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
isasud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
isasud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
isasud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
isasud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
isasud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
isasud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
isasud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
isasud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
isasud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table isas_t add constraint isas_pk primary key (isasent,isascomp,isassite,isas001,isas002,isas003,isas011,isas014) enable validate;

create unique index isas_pk on isas_t (isasent,isascomp,isassite,isas001,isas002,isas003,isas011,isas014);

grant select on isas_t to tiptop;
grant update on isas_t to tiptop;
grant delete on isas_t to tiptop;
grant insert on isas_t to tiptop;

exit;
