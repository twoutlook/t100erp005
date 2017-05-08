/* 
================================================================================
檔案代號:rtkd_t
檔案名稱:自動補貨供應商及配送中心休假日設定檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table rtkd_t
(
rtkdent       number(5)      ,/* 企業編號 */
rtkdunit       varchar2(10)      ,/* 應用組織 */
rtkd001       varchar2(1)      ,/* 資料類型 */
rtkd002       varchar2(10)      ,/* 供應商/倉庫編號 */
rtkd003       number(10,0)      ,/* 項次 */
rtkd004       date      ,/* 計算起始日 */
rtkd005       date      ,/* 計算結束日 */
rtkd006       number(5,0)      ,/* 補貨年節日天數 */
rtkd007       varchar2(255)      ,/* 備註 */
rtkdownid       varchar2(20)      ,/* 資料所有者 */
rtkdowndp       varchar2(10)      ,/* 資料所屬部門 */
rtkdcrtid       varchar2(20)      ,/* 資料建立者 */
rtkdcrtdp       varchar2(10)      ,/* 資料建立部門 */
rtkdcrtdt       timestamp(0)      ,/* 資料創建日 */
rtkdmodid       varchar2(20)      ,/* 資料修改者 */
rtkdmoddt       timestamp(0)      ,/* 最近修改日 */
rtkdstus       varchar2(10)      ,/* 狀態碼 */
rtkdud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
rtkdud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
rtkdud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
rtkdud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
rtkdud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
rtkdud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
rtkdud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
rtkdud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
rtkdud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
rtkdud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
rtkdud011       number(20,6)      ,/* 自定義欄位(數字)011 */
rtkdud012       number(20,6)      ,/* 自定義欄位(數字)012 */
rtkdud013       number(20,6)      ,/* 自定義欄位(數字)013 */
rtkdud014       number(20,6)      ,/* 自定義欄位(數字)014 */
rtkdud015       number(20,6)      ,/* 自定義欄位(數字)015 */
rtkdud016       number(20,6)      ,/* 自定義欄位(數字)016 */
rtkdud017       number(20,6)      ,/* 自定義欄位(數字)017 */
rtkdud018       number(20,6)      ,/* 自定義欄位(數字)018 */
rtkdud019       number(20,6)      ,/* 自定義欄位(數字)019 */
rtkdud020       number(20,6)      ,/* 自定義欄位(數字)020 */
rtkdud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
rtkdud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
rtkdud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
rtkdud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
rtkdud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
rtkdud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
rtkdud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
rtkdud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
rtkdud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
rtkdud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table rtkd_t add constraint rtkd_pk primary key (rtkdent,rtkd001,rtkd002,rtkd003) enable validate;

create unique index rtkd_pk on rtkd_t (rtkdent,rtkd001,rtkd002,rtkd003);

grant select on rtkd_t to tiptop;
grant update on rtkd_t to tiptop;
grant delete on rtkd_t to tiptop;
grant insert on rtkd_t to tiptop;

exit;
