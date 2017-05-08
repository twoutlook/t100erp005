/* 
================================================================================
檔案代號:pmat_t
檔案名稱:供應商料號分配比率檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table pmat_t
(
pmatent       number(5)      ,/* 企業編號 */
pmatsite       varchar2(10)      ,/* 營運據點 */
pmat001       varchar2(10)      ,/* 供應商編號 */
pmat002       varchar2(40)      ,/* 料件編號 */
pmat003       varchar2(256)      ,/* 產品特徵 */
pmat004       number(20,6)      ,/* 分配比率 */
pmatownid       varchar2(20)      ,/* 資料所有者 */
pmatowndp       varchar2(10)      ,/* 資料所屬部門 */
pmatcrtid       varchar2(20)      ,/* 資料建立者 */
pmatcrtdp       varchar2(10)      ,/* 資料建立部門 */
pmatcrtdt       timestamp(0)      ,/* 資料創建日 */
pmatmodid       varchar2(20)      ,/* 資料修改者 */
pmatmoddt       timestamp(0)      ,/* 最近修改日 */
pmatstus       varchar2(10)      ,/* 狀態碼 */
pmatud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
pmatud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
pmatud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
pmatud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
pmatud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
pmatud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
pmatud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
pmatud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
pmatud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
pmatud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
pmatud011       number(20,6)      ,/* 自定義欄位(數字)011 */
pmatud012       number(20,6)      ,/* 自定義欄位(數字)012 */
pmatud013       number(20,6)      ,/* 自定義欄位(數字)013 */
pmatud014       number(20,6)      ,/* 自定義欄位(數字)014 */
pmatud015       number(20,6)      ,/* 自定義欄位(數字)015 */
pmatud016       number(20,6)      ,/* 自定義欄位(數字)016 */
pmatud017       number(20,6)      ,/* 自定義欄位(數字)017 */
pmatud018       number(20,6)      ,/* 自定義欄位(數字)018 */
pmatud019       number(20,6)      ,/* 自定義欄位(數字)019 */
pmatud020       number(20,6)      ,/* 自定義欄位(數字)020 */
pmatud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
pmatud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
pmatud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
pmatud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
pmatud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
pmatud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
pmatud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
pmatud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
pmatud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
pmatud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table pmat_t add constraint pmat_pk primary key (pmatent,pmatsite,pmat001,pmat002,pmat003) enable validate;

create unique index pmat_pk on pmat_t (pmatent,pmatsite,pmat001,pmat002,pmat003);

grant select on pmat_t to tiptop;
grant update on pmat_t to tiptop;
grant delete on pmat_t to tiptop;
grant insert on pmat_t to tiptop;

exit;
