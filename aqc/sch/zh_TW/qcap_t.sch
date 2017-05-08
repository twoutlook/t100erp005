/* 
================================================================================
檔案代號:qcap_t
檔案名稱:料件供應商檢驗資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table qcap_t
(
qcapent       number(5)      ,/* 企業編號 */
qcapsite       varchar2(10)      ,/* 營運據點 */
qcap001       varchar2(40)      ,/* 料件編號 */
qcap002       varchar2(10)      ,/* 供應商編號 */
qcap003       varchar2(10)      ,/* 作業編號 */
qcap004       number(10,0)      ,/* 加工序 */
qcap005       varchar2(256)      ,/* 產品特徵 */
qcap006       varchar2(1)      ,/* 是否進料檢驗 */
qcap007       varchar2(10)      ,/* 檢驗程度 */
qcap008       varchar2(10)      ,/* 檢驗水準 */
qcap009       varchar2(10)      ,/* 檢驗級數 */
qcapownid       varchar2(20)      ,/* 資料所有者 */
qcapowndp       varchar2(10)      ,/* 資料所屬部門 */
qcapcrtid       varchar2(20)      ,/* 資料建立者 */
qcapcrtdp       varchar2(10)      ,/* 資料建立部門 */
qcapcrtdt       timestamp(0)      ,/* 資料創建日 */
qcapmodid       varchar2(20)      ,/* 資料修改者 */
qcapmoddt       timestamp(0)      ,/* 最近修改日 */
qcapstus       varchar2(10)      ,/* 狀態碼 */
qcapud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
qcapud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
qcapud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
qcapud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
qcapud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
qcapud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
qcapud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
qcapud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
qcapud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
qcapud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
qcapud011       number(20,6)      ,/* 自定義欄位(數字)011 */
qcapud012       number(20,6)      ,/* 自定義欄位(數字)012 */
qcapud013       number(20,6)      ,/* 自定義欄位(數字)013 */
qcapud014       number(20,6)      ,/* 自定義欄位(數字)014 */
qcapud015       number(20,6)      ,/* 自定義欄位(數字)015 */
qcapud016       number(20,6)      ,/* 自定義欄位(數字)016 */
qcapud017       number(20,6)      ,/* 自定義欄位(數字)017 */
qcapud018       number(20,6)      ,/* 自定義欄位(數字)018 */
qcapud019       number(20,6)      ,/* 自定義欄位(數字)019 */
qcapud020       number(20,6)      ,/* 自定義欄位(數字)020 */
qcapud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
qcapud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
qcapud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
qcapud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
qcapud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
qcapud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
qcapud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
qcapud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
qcapud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
qcapud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table qcap_t add constraint qcap_pk primary key (qcapent,qcapsite,qcap001,qcap002,qcap003,qcap004,qcap005) enable validate;

create unique index qcap_pk on qcap_t (qcapent,qcapsite,qcap001,qcap002,qcap003,qcap004,qcap005);

grant select on qcap_t to tiptop;
grant update on qcap_t to tiptop;
grant delete on qcap_t to tiptop;
grant insert on qcap_t to tiptop;

exit;
