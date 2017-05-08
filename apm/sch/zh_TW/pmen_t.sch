/* 
================================================================================
檔案代號:pmen_t
檔案名稱:碼頭基礎資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table pmen_t
(
pmenent       number(5)      ,/* 企業代碼 */
pmensite       varchar2(10)      ,/* 營運據點 */
pmenunit       varchar2(10)      ,/* 應用組織 */
pmen001       varchar2(10)      ,/* 碼頭編號 */
pmen002       varchar2(10)      ,/* 碼頭類型 */
pmen003       varchar2(1)      ,/* 是否歸屬庫區 */
pmen004       varchar2(10)      ,/* 庫區編號 */
pmen005       varchar2(10)      ,/* 場地 */
pmen006       varchar2(10)      ,/* 區域 */
pmen007       varchar2(10)      ,/* 樓層 */
pmen008       varchar2(10)      ,/* 樓棟 */
pmen009       date      ,/* 啟用日期 */
pmenownid       varchar2(20)      ,/* 資料所有者 */
pmenowndp       varchar2(10)      ,/* 資料所屬部門 */
pmencrtid       varchar2(20)      ,/* 資料建立者 */
pmencrtdp       varchar2(10)      ,/* 資料建立部門 */
pmencrtdt       timestamp(0)      ,/* 資料創建日 */
pmenmodid       varchar2(20)      ,/* 資料修改者 */
pmenmoddt       timestamp(0)      ,/* 最近修改日 */
pmenstus       varchar2(10)      ,/* 狀態碼 */
pmenud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
pmenud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
pmenud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
pmenud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
pmenud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
pmenud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
pmenud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
pmenud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
pmenud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
pmenud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
pmenud011       number(20,6)      ,/* 自定義欄位(數字)011 */
pmenud012       number(20,6)      ,/* 自定義欄位(數字)012 */
pmenud013       number(20,6)      ,/* 自定義欄位(數字)013 */
pmenud014       number(20,6)      ,/* 自定義欄位(數字)014 */
pmenud015       number(20,6)      ,/* 自定義欄位(數字)015 */
pmenud016       number(20,6)      ,/* 自定義欄位(數字)016 */
pmenud017       number(20,6)      ,/* 自定義欄位(數字)017 */
pmenud018       number(20,6)      ,/* 自定義欄位(數字)018 */
pmenud019       number(20,6)      ,/* 自定義欄位(數字)019 */
pmenud020       number(20,6)      ,/* 自定義欄位(數字)020 */
pmenud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
pmenud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
pmenud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
pmenud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
pmenud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
pmenud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
pmenud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
pmenud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
pmenud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
pmenud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table pmen_t add constraint pmen_pk primary key (pmenent,pmensite,pmen001) enable validate;

create unique index pmen_pk on pmen_t (pmenent,pmensite,pmen001);

grant select on pmen_t to tiptop;
grant update on pmen_t to tiptop;
grant delete on pmen_t to tiptop;
grant insert on pmen_t to tiptop;

exit;
