/* 
================================================================================
檔案代號:mhac_t
檔案名稱:區域基本資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table mhac_t
(
mhacent       number(5)      ,/* 企業編號 */
mhacsite       varchar2(10)      ,/* 營運據點 */
mhacunit       varchar2(10)      ,/* 應用組織 */
mhac001       varchar2(10)      ,/* 樓棟編號 */
mhac002       varchar2(10)      ,/* 樓層編號 */
mhac003       varchar2(10)      ,/* 區域編號 */
mhac004       number(20,6)      ,/* 建築面積 */
mhac005       number(20,6)      ,/* 測量面積 */
mhac006       number(20,6)      ,/* 經營面積 */
mhacstus       varchar2(10)      ,/* 狀態碼 */
mhacownid       varchar2(20)      ,/* 資料所有者 */
mhacowndp       varchar2(10)      ,/* 資料所屬部門 */
mhaccrtid       varchar2(20)      ,/* 資料建立者 */
mhaccrtdp       varchar2(10)      ,/* 資料建立部門 */
mhaccrtdt       timestamp(0)      ,/* 資料創建日 */
mhacmodid       varchar2(20)      ,/* 資料修改者 */
mhacmoddt       timestamp(0)      ,/* 最近修改日 */
mhacud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
mhacud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
mhacud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
mhacud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
mhacud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
mhacud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
mhacud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
mhacud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
mhacud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
mhacud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
mhacud011       number(20,6)      ,/* 自定義欄位(數字)011 */
mhacud012       number(20,6)      ,/* 自定義欄位(數字)012 */
mhacud013       number(20,6)      ,/* 自定義欄位(數字)013 */
mhacud014       number(20,6)      ,/* 自定義欄位(數字)014 */
mhacud015       number(20,6)      ,/* 自定義欄位(數字)015 */
mhacud016       number(20,6)      ,/* 自定義欄位(數字)016 */
mhacud017       number(20,6)      ,/* 自定義欄位(數字)017 */
mhacud018       number(20,6)      ,/* 自定義欄位(數字)018 */
mhacud019       number(20,6)      ,/* 自定義欄位(數字)019 */
mhacud020       number(20,6)      ,/* 自定義欄位(數字)020 */
mhacud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
mhacud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
mhacud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
mhacud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
mhacud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
mhacud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
mhacud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
mhacud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
mhacud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
mhacud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table mhac_t add constraint mhac_pk primary key (mhacent,mhac001,mhac002,mhac003) enable validate;

create unique index mhac_pk on mhac_t (mhacent,mhac001,mhac002,mhac003);

grant select on mhac_t to tiptop;
grant update on mhac_t to tiptop;
grant delete on mhac_t to tiptop;
grant insert on mhac_t to tiptop;

exit;
