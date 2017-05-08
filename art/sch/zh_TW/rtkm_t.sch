/* 
================================================================================
檔案代號:rtkm_t
檔案名稱:補貨建議單資料表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table rtkm_t
(
rtkment       number(5)      ,/* 企業編號 */
rtkmsite       varchar2(10)      ,/* 營運據點 */
rtkmunit       varchar2(10)      ,/* 應用組織 */
rtkmdocno       varchar2(20)      ,/* 單據編號 */
rtkmdocdt       date      ,/* 單據日期 */
rtkm001       date      ,/* 補貨日期 */
rtkm002       varchar2(20)      ,/* 補貨人員 */
rtkm003       varchar2(10)      ,/* 部門編號 */
rtkm004       varchar2(20)      ,/* 要貨單號 */
rtkmstus       varchar2(10)      ,/* 狀態碼 */
rtkmownid       varchar2(20)      ,/* 資料所有者 */
rtkmowndp       varchar2(10)      ,/* 資料所屬部門 */
rtkmcrtid       varchar2(20)      ,/* 資料建立者 */
rtkmcrtdp       varchar2(10)      ,/* 資料建立部門 */
rtkmcrtdt       timestamp(0)      ,/* 資料創建日 */
rtkmmodid       varchar2(20)      ,/* 資料修改者 */
rtkmmoddt       timestamp(0)      ,/* 最近修改日 */
rtkmcnfid       varchar2(20)      ,/* 資料確認者 */
rtkmcnfdt       timestamp(0)      ,/* 資料確認日 */
rtkmud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
rtkmud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
rtkmud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
rtkmud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
rtkmud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
rtkmud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
rtkmud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
rtkmud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
rtkmud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
rtkmud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
rtkmud011       number(20,6)      ,/* 自定義欄位(數字)011 */
rtkmud012       number(20,6)      ,/* 自定義欄位(數字)012 */
rtkmud013       number(20,6)      ,/* 自定義欄位(數字)013 */
rtkmud014       number(20,6)      ,/* 自定義欄位(數字)014 */
rtkmud015       number(20,6)      ,/* 自定義欄位(數字)015 */
rtkmud016       number(20,6)      ,/* 自定義欄位(數字)016 */
rtkmud017       number(20,6)      ,/* 自定義欄位(數字)017 */
rtkmud018       number(20,6)      ,/* 自定義欄位(數字)018 */
rtkmud019       number(20,6)      ,/* 自定義欄位(數字)019 */
rtkmud020       number(20,6)      ,/* 自定義欄位(數字)020 */
rtkmud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
rtkmud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
rtkmud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
rtkmud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
rtkmud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
rtkmud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
rtkmud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
rtkmud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
rtkmud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
rtkmud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table rtkm_t add constraint rtkm_pk primary key (rtkment,rtkmdocno) enable validate;

create unique index rtkm_pk on rtkm_t (rtkment,rtkmdocno);

grant select on rtkm_t to tiptop;
grant update on rtkm_t to tiptop;
grant delete on rtkm_t to tiptop;
grant insert on rtkm_t to tiptop;

exit;
