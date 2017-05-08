/* 
================================================================================
檔案代號:rtdu_t
檔案名稱:自營新商品引進單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table rtdu_t
(
rtduent       number(5)      ,/* 企業編號 */
rtdudocno       varchar2(20)      ,/* 單據編號 */
rtdudocdt       date      ,/* 單據日期 */
rtdu001       varchar2(10)      ,/* 供應商 */
rtdu002       varchar2(20)      ,/* 合約編號 */
rtdu003       varchar2(10)      ,/* 經營方式 */
rtdu004       varchar2(10)      ,/* 結算方式 */
rtdu005       varchar2(10)      ,/* 採購中心 */
rtdu006       varchar2(20)      ,/* 採購員 */
rtdu007       varchar2(10)      ,/* 配送中心 */
rtdu008       varchar2(10)      ,/* 店群 */
rtdu009       varchar2(10)      ,/* 生命週期 */
rtdu010       varchar2(255)      ,/* 備註 */
rtdustus       varchar2(10)      ,/* 狀態碼 */
rtduownid       varchar2(20)      ,/* 資料所有者 */
rtduowndp       varchar2(10)      ,/* 資料所有部門 */
rtducrtid       varchar2(20)      ,/* 資料建立者 */
rtducrtdp       varchar2(10)      ,/* 資料建立部門 */
rtducrtdt       timestamp(0)      ,/* 資料創建日 */
rtdumodid       varchar2(20)      ,/* 資料修改者 */
rtdumoddt       timestamp(0)      ,/* 最近修改日 */
rtducnfid       varchar2(20)      ,/* 資料確認者 */
rtducnfdt       timestamp(0)      ,/* 資料確認日 */
rtduud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
rtduud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
rtduud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
rtduud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
rtduud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
rtduud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
rtduud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
rtduud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
rtduud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
rtduud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
rtduud011       number(20,6)      ,/* 自定義欄位(數字)011 */
rtduud012       number(20,6)      ,/* 自定義欄位(數字)012 */
rtduud013       number(20,6)      ,/* 自定義欄位(數字)013 */
rtduud014       number(20,6)      ,/* 自定義欄位(數字)014 */
rtduud015       number(20,6)      ,/* 自定義欄位(數字)015 */
rtduud016       number(20,6)      ,/* 自定義欄位(數字)016 */
rtduud017       number(20,6)      ,/* 自定義欄位(數字)017 */
rtduud018       number(20,6)      ,/* 自定義欄位(數字)018 */
rtduud019       number(20,6)      ,/* 自定義欄位(數字)019 */
rtduud020       number(20,6)      ,/* 自定義欄位(數字)020 */
rtduud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
rtduud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
rtduud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
rtduud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
rtduud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
rtduud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
rtduud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
rtduud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
rtduud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
rtduud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
rtduunit       varchar2(10)      ,/* 應用組織 */
rtdusite       varchar2(10)      ,/* 營運據點 */
rtdu011       varchar2(10)      ,/* 稅區別 */
rtdu000       varchar2(10)      ,/* 作業方式 */
rtdu012       varchar2(10)      /* 採購方式 */
);
alter table rtdu_t add constraint rtdu_pk primary key (rtduent,rtdudocno) enable validate;

create unique index rtdu_pk on rtdu_t (rtduent,rtdudocno);

grant select on rtdu_t to tiptop;
grant update on rtdu_t to tiptop;
grant delete on rtdu_t to tiptop;
grant insert on rtdu_t to tiptop;

exit;
