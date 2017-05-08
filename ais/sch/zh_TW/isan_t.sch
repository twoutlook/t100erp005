/* 
================================================================================
檔案代號:isan_t
檔案名稱:稅別公式基本資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table isan_t
(
isanent       number(5)      ,/* 企業編號 */
isan001       varchar2(10)      ,/* 交易稅區 */
isan002       varchar2(10)      ,/* 公式代碼 */
isan003       number(10,0)      ,/* 計算順序 */
isan004       varchar2(10)      ,/* 計徵方式 */
isan005       varchar2(10)      ,/* 計稅基準 */
isan006       number(5,2)      ,/* 稅率 */
isan007       number(20,6)      ,/* 固定稅額 */
isan008       varchar2(256)      ,/* 未稅公式 */
isan009       varchar2(256)      ,/* 稅額公式 */
isanstus       varchar2(1)      ,/* 狀態碼 */
isanownid       varchar2(20)      ,/* 資料所有者 */
isanowndp       varchar2(10)      ,/* 資料所屬部門 */
isancrtid       varchar2(20)      ,/* 資料建立者 */
isancrtdp       varchar2(10)      ,/* 資料建立部門 */
isancrtdt       timestamp(0)      ,/* 資料創建日 */
isanmodid       varchar2(20)      ,/* 資料修改者 */
isanmoddt       timestamp(0)      ,/* 最近修改日 */
isanud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
isanud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
isanud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
isanud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
isanud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
isanud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
isanud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
isanud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
isanud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
isanud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
isanud011       number(20,6)      ,/* 自定義欄位(數字)011 */
isanud012       number(20,6)      ,/* 自定義欄位(數字)012 */
isanud013       number(20,6)      ,/* 自定義欄位(數字)013 */
isanud014       number(20,6)      ,/* 自定義欄位(數字)014 */
isanud015       number(20,6)      ,/* 自定義欄位(數字)015 */
isanud016       number(20,6)      ,/* 自定義欄位(數字)016 */
isanud017       number(20,6)      ,/* 自定義欄位(數字)017 */
isanud018       number(20,6)      ,/* 自定義欄位(數字)018 */
isanud019       number(20,6)      ,/* 自定義欄位(數字)019 */
isanud020       number(20,6)      ,/* 自定義欄位(數字)020 */
isanud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
isanud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
isanud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
isanud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
isanud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
isanud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
isanud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
isanud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
isanud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
isanud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table isan_t add constraint isan_pk primary key (isanent,isan001,isan002,isan003) enable validate;

create unique index isan_pk on isan_t (isanent,isan001,isan002,isan003);

grant select on isan_t to tiptop;
grant update on isan_t to tiptop;
grant delete on isan_t to tiptop;
grant insert on isan_t to tiptop;

exit;
