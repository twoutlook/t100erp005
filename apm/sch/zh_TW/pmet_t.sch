/* 
================================================================================
檔案代號:pmet_t
檔案名稱:要貨組織預設要貨資料單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table pmet_t
(
pmetent       number(5)      ,/* 企業編號 */
pmetsite       varchar2(10)      ,/* 營運據點 */
pmetunit       varchar2(10)      ,/* 應用組織 */
pmet001       varchar2(10)      ,/* 要貨部門 */
pmet002       varchar2(10)      ,/* 要貨模板編號 */
pmetownid       varchar2(20)      ,/* 資料所有者 */
pmetowndp       varchar2(10)      ,/* 資料所屬部門 */
pmetcrtid       varchar2(20)      ,/* 資料建立者 */
pmetcrtdp       varchar2(10)      ,/* 資料建立部門 */
pmetcrtdt       timestamp(0)      ,/* 資料創建日 */
pmetmodid       varchar2(20)      ,/* 資料修改者 */
pmetmoddt       timestamp(0)      ,/* 最近修改日 */
pmetstus       varchar2(10)      ,/* 狀態碼 */
pmetud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
pmetud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
pmetud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
pmetud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
pmetud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
pmetud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
pmetud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
pmetud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
pmetud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
pmetud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
pmetud011       number(20,6)      ,/* 自定義欄位(數字)011 */
pmetud012       number(20,6)      ,/* 自定義欄位(數字)012 */
pmetud013       number(20,6)      ,/* 自定義欄位(數字)013 */
pmetud014       number(20,6)      ,/* 自定義欄位(數字)014 */
pmetud015       number(20,6)      ,/* 自定義欄位(數字)015 */
pmetud016       number(20,6)      ,/* 自定義欄位(數字)016 */
pmetud017       number(20,6)      ,/* 自定義欄位(數字)017 */
pmetud018       number(20,6)      ,/* 自定義欄位(數字)018 */
pmetud019       number(20,6)      ,/* 自定義欄位(數字)019 */
pmetud020       number(20,6)      ,/* 自定義欄位(數字)020 */
pmetud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
pmetud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
pmetud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
pmetud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
pmetud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
pmetud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
pmetud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
pmetud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
pmetud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
pmetud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table pmet_t add constraint pmet_pk primary key (pmetent,pmetsite,pmet001) enable validate;

create unique index pmet_pk on pmet_t (pmetent,pmetsite,pmet001);

grant select on pmet_t to tiptop;
grant update on pmet_t to tiptop;
grant delete on pmet_t to tiptop;
grant insert on pmet_t to tiptop;

exit;
