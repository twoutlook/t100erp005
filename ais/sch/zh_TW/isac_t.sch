/* 
================================================================================
檔案代號:isac_t
檔案名稱:發票類型維護
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table isac_t
(
isacent       number(5)      ,/* 企業編號 */
isacownid       varchar2(20)      ,/* 資料所有者 */
isacowndp       varchar2(10)      ,/* 資料所屬部門 */
isaccrtid       varchar2(20)      ,/* 資料建立者 */
isaccrtdp       varchar2(10)      ,/* 資料建立部門 */
isaccrtdt       timestamp(0)      ,/* 資料創建日 */
isacmodid       varchar2(20)      ,/* 資料修改者 */
isacmoddt       timestamp(0)      ,/* 最近修改日 */
isacstus       varchar2(10)      ,/* 狀態碼 */
isac001       varchar2(10)      ,/* 交易稅區 */
isac002       varchar2(2)      ,/* 發票類型 */
isac003       varchar2(1)      ,/* 發票歸屬進銷項 */
isac004       varchar2(10)      ,/* 媒體申報格式 */
isac005       varchar2(1)      ,/* 計稅原則 */
isac006       number(5,0)      ,/* 發票明細筆數 */
isac007       varchar2(10)      ,/* 容差額 */
isac008       varchar2(10)      ,/* 發票聯數 */
isac009       varchar2(255)      ,/* 對應折單類型 */
isac010       varchar2(1)      ,/* 允許多稅率否 */
isac011       number(5,0)      ,/* 發票張數 */
isac012       varchar2(1)      ,/* 不同稅務編號可調撥否 */
isacud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
isacud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
isacud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
isacud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
isacud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
isacud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
isacud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
isacud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
isacud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
isacud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
isacud011       number(20,6)      ,/* 自定義欄位(數字)011 */
isacud012       number(20,6)      ,/* 自定義欄位(數字)012 */
isacud013       number(20,6)      ,/* 自定義欄位(數字)013 */
isacud014       number(20,6)      ,/* 自定義欄位(數字)014 */
isacud015       number(20,6)      ,/* 自定義欄位(數字)015 */
isacud016       number(20,6)      ,/* 自定義欄位(數字)016 */
isacud017       number(20,6)      ,/* 自定義欄位(數字)017 */
isacud018       number(20,6)      ,/* 自定義欄位(數字)018 */
isacud019       number(20,6)      ,/* 自定義欄位(數字)019 */
isacud020       number(20,6)      ,/* 自定義欄位(數字)020 */
isacud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
isacud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
isacud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
isacud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
isacud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
isacud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
isacud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
isacud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
isacud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
isacud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table isac_t add constraint isac_pk primary key (isacent,isac001,isac002) enable validate;

create unique index isac_pk on isac_t (isacent,isac001,isac002);

grant select on isac_t to tiptop;
grant update on isac_t to tiptop;
grant delete on isac_t to tiptop;
grant insert on isac_t to tiptop;

exit;
