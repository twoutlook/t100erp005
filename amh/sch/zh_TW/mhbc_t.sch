/* 
================================================================================
檔案代號:mhbc_t
檔案名稱:鋪位申請資料表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table mhbc_t
(
mhbcent       number(5)      ,/* 企業編號 */
mhbcsite       varchar2(10)      ,/* 營運組織 */
mhbcunit       varchar2(10)      ,/* 應用組織 */
mhbcdocno       varchar2(20)      ,/* 單據編號 */
mhbcdocdt       date      ,/* 單據日期 */
mhbc000       varchar2(10)      ,/* 作業類型 */
mhbc001       varchar2(20)      ,/* 鋪位編號 */
mhbc002       number(5,0)      ,/* 鋪位版本 */
mhbc003       varchar2(10)      ,/* 樓棟編號 */
mhbc004       varchar2(10)      ,/* 樓層編號 */
mhbc005       varchar2(10)      ,/* 區域編號 */
mhbc006       number(20,6)      ,/* 建築面積 */
mhbc007       number(20,6)      ,/* 測量面積 */
mhbc008       number(20,6)      ,/* 經營面積 */
mhbc009       varchar2(10)      ,/* 管理品類 */
mhbc010       varchar2(10)      ,/* 鋪位用途 */
mhbc011       varchar2(255)      ,/* 門牌號 */
mhbc012       varchar2(10)      ,/* 鋪位狀態 */
mhbc013       varchar2(20)      ,/* 業務人員 */
mhbc014       varchar2(10)      ,/* 部門編號 */
mhbc015       varchar2(80)      ,/* 備註 */
mhbc016       varchar2(20)      ,/* 面積申請單 */
mhbc017       varchar2(10)      ,/* 鋪位等級 */
mhbcstus       varchar2(10)      ,/* 狀態碼 */
mhbcownid       varchar2(20)      ,/* 資料所有者 */
mhbcowndp       varchar2(10)      ,/* 資料所屬部門 */
mhbccrtid       varchar2(20)      ,/* 資料建立者 */
mhbccrtdp       varchar2(10)      ,/* 資料建立部門 */
mhbccrtdt       timestamp(0)      ,/* 資料創建日 */
mhbcmodid       varchar2(20)      ,/* 資料修改者 */
mhbcmoddt       timestamp(0)      ,/* 最近修改日 */
mhbccnfid       varchar2(20)      ,/* 資料確認者 */
mhbccnfdt       timestamp(0)      ,/* 資料確認日 */
mhbcud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
mhbcud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
mhbcud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
mhbcud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
mhbcud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
mhbcud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
mhbcud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
mhbcud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
mhbcud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
mhbcud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
mhbcud011       number(20,6)      ,/* 自定義欄位(數字)011 */
mhbcud012       number(20,6)      ,/* 自定義欄位(數字)012 */
mhbcud013       number(20,6)      ,/* 自定義欄位(數字)013 */
mhbcud014       number(20,6)      ,/* 自定義欄位(數字)014 */
mhbcud015       number(20,6)      ,/* 自定義欄位(數字)015 */
mhbcud016       number(20,6)      ,/* 自定義欄位(數字)016 */
mhbcud017       number(20,6)      ,/* 自定義欄位(數字)017 */
mhbcud018       number(20,6)      ,/* 自定義欄位(數字)018 */
mhbcud019       number(20,6)      ,/* 自定義欄位(數字)019 */
mhbcud020       number(20,6)      ,/* 自定義欄位(數字)020 */
mhbcud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
mhbcud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
mhbcud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
mhbcud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
mhbcud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
mhbcud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
mhbcud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
mhbcud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
mhbcud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
mhbcud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table mhbc_t add constraint mhbc_pk primary key (mhbcent,mhbcdocno) enable validate;

create unique index mhbc_pk on mhbc_t (mhbcent,mhbcdocno);

grant select on mhbc_t to tiptop;
grant update on mhbc_t to tiptop;
grant delete on mhbc_t to tiptop;
grant insert on mhbc_t to tiptop;

exit;
