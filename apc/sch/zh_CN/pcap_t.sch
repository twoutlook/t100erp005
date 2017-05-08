/* 
================================================================================
檔案代號:pcap_t
檔案名稱:Service差異調整單
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table pcap_t
(
pcapent       number(5)      ,/* 企業編號 */
pcapunit       varchar2(10)      ,/* 應用組織 */
pcapsite       varchar2(10)      ,/* 營運組織 */
pcapdocno       varchar2(20)      ,/* 單據編號 */
pcapdocdt       date      ,/* 單據日期 */
pcap001       varchar2(20)      ,/* 調整人員 */
pcap002       varchar2(10)      ,/* 調整部門 */
pcap003       varchar2(40)      ,/* 備註 */
pcap014       varchar2(10)      ,/* 狀態 */
pcapstus       varchar2(10)      ,/* 狀態碼 */
pcapownid       varchar2(20)      ,/* 資料所有者 */
pcapowndp       varchar2(10)      ,/* 資料所屬部門 */
pcapcrtid       varchar2(20)      ,/* 資料建立者 */
pcapcrtdp       varchar2(10)      ,/* 資料建立部門 */
pcapcrtdt       timestamp(0)      ,/* 資料創建日 */
pcapmodid       varchar2(20)      ,/* 資料修改者 */
pcapmoddt       timestamp(0)      ,/* 最近修改日 */
pcapcnfid       varchar2(20)      ,/* 資料確認者 */
pcapcnfdt       timestamp(0)      ,/* 資料確認日 */
pcapud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
pcapud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
pcapud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
pcapud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
pcapud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
pcapud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
pcapud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
pcapud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
pcapud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
pcapud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
pcapud011       number(20,6)      ,/* 自定義欄位(數字)011 */
pcapud012       number(20,6)      ,/* 自定義欄位(數字)012 */
pcapud013       number(20,6)      ,/* 自定義欄位(數字)013 */
pcapud014       number(20,6)      ,/* 自定義欄位(數字)014 */
pcapud015       number(20,6)      ,/* 自定義欄位(數字)015 */
pcapud016       number(20,6)      ,/* 自定義欄位(數字)016 */
pcapud017       number(20,6)      ,/* 自定義欄位(數字)017 */
pcapud018       number(20,6)      ,/* 自定義欄位(數字)018 */
pcapud019       number(20,6)      ,/* 自定義欄位(數字)019 */
pcapud020       number(20,6)      ,/* 自定義欄位(數字)020 */
pcapud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
pcapud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
pcapud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
pcapud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
pcapud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
pcapud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
pcapud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
pcapud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
pcapud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
pcapud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table pcap_t add constraint pcap_pk primary key (pcapent,pcapdocno) enable validate;

create unique index pcap_pk on pcap_t (pcapent,pcapdocno);

grant select on pcap_t to tiptop;
grant update on pcap_t to tiptop;
grant delete on pcap_t to tiptop;
grant insert on pcap_t to tiptop;

exit;
