/* 
================================================================================
檔案代號:rtde_t
檔案名稱:商品生命週期調整檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table rtde_t
(
rtdeent       number(5)      ,/* 企業編號 */
rtdesite       varchar2(10)      ,/* 營運據點 */
rtdeunit       varchar2(10)      ,/* 應用組織 */
rtdedocno       varchar2(20)      ,/* 單據編號 */
rtdedocdt       date      ,/* 單據日期 */
rtde001       varchar2(10)      ,/* 來源類型 */
rtde002       varchar2(20)      ,/* 調整人員 */
rtde003       varchar2(10)      ,/* 調整部門 */
rtde004       varchar2(80)      ,/* 備註 */
rtdestus       varchar2(10)      ,/* 狀態 */
rtdeownid       varchar2(20)      ,/* 資料所有者 */
rtdeowndp       varchar2(10)      ,/* 資料所屬部門 */
rtdecrtid       varchar2(20)      ,/* 資料建立者 */
rtdecrtdp       varchar2(10)      ,/* 資料建立部門 */
rtdecrtdt       timestamp(0)      ,/* 資料創建日 */
rtdemodid       varchar2(20)      ,/* 資料修改者 */
rtdemoddt       timestamp(0)      ,/* 最近修改日 */
rtdecnfid       varchar2(20)      ,/* 資料確認者 */
rtdecnfdt       timestamp(0)      ,/* 資料確認日 */
rtdeud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
rtdeud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
rtdeud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
rtdeud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
rtdeud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
rtdeud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
rtdeud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
rtdeud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
rtdeud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
rtdeud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
rtdeud011       number(20,6)      ,/* 自定義欄位(數字)011 */
rtdeud012       number(20,6)      ,/* 自定義欄位(數字)012 */
rtdeud013       number(20,6)      ,/* 自定義欄位(數字)013 */
rtdeud014       number(20,6)      ,/* 自定義欄位(數字)014 */
rtdeud015       number(20,6)      ,/* 自定義欄位(數字)015 */
rtdeud016       number(20,6)      ,/* 自定義欄位(數字)016 */
rtdeud017       number(20,6)      ,/* 自定義欄位(數字)017 */
rtdeud018       number(20,6)      ,/* 自定義欄位(數字)018 */
rtdeud019       number(20,6)      ,/* 自定義欄位(數字)019 */
rtdeud020       number(20,6)      ,/* 自定義欄位(數字)020 */
rtdeud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
rtdeud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
rtdeud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
rtdeud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
rtdeud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
rtdeud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
rtdeud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
rtdeud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
rtdeud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
rtdeud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
rtde005       varchar2(10)      /* 供應商編號 */
);
alter table rtde_t add constraint rtde_pk primary key (rtdeent,rtdedocno) enable validate;

create unique index rtde_pk on rtde_t (rtdeent,rtdedocno);

grant select on rtde_t to tiptop;
grant update on rtde_t to tiptop;
grant delete on rtde_t to tiptop;
grant insert on rtde_t to tiptop;

exit;
