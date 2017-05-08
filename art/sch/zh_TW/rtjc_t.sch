/* 
================================================================================
檔案代號:rtjc_t
檔案名稱:銷售整合折扣明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:Y
============.========================.==========================================
 */
create table rtjc_t
(
rtjcent       number(5)      ,/* 企業編號 */
rtjcsite       varchar2(10)      ,/* 營運據點 */
rtjcunit       varchar2(10)      ,/* 應用組織 */
rtjcdocno       varchar2(20)      ,/* 單據編號 */
rtjcseq       number(10,0)      ,/* 項次 */
rtjcseq1       number(10,0)      ,/* 折扣序 */
rtjc001       varchar2(10)      ,/* 單據類型 */
rtjc002       varchar2(10)      ,/* 折價方式 */
rtjc003       varchar2(30)      ,/* 促銷規則 */
rtjc004       varchar2(10)      ,/* 活動類別 */
rtjc005       varchar2(10)      ,/* 活動子類別 */
rtjc006       varchar2(10)      ,/* 促銷方式 */
rtjc007       varchar2(10)      ,/* 入机方式 */
rtjc008       number(20,6)      ,/* 參與數量 */
rtjc009       number(20,6)      ,/* 參與金額 */
rtjc010       number(20,6)      ,/* 贈送基數 */
rtjc011       number(20,6)      ,/* 贈送幅度 */
rtjc012       number(20,6)      ,/* 折扣率 */
rtjc013       number(20,6)      ,/* 折讓金額 */
rtjc014       varchar2(10)      ,/* 贈卡券種 */
rtjc015       varchar2(30)      ,/* 贈卡券號 */
rtjc016       number(20,6)      ,/* 贈送面額 */
rtjc017       number(20,6)      ,/* 贈送面額單位金額 */
rtjc018       varchar2(10)      ,/* 接卡券種 */
rtjc019       varchar2(30)      ,/* 接卡券號 */
rtjc020       number(20,6)      ,/* 接收基數 */
rtjc021       number(20,6)      ,/* 接收幅度 */
rtjc022       number(20,6)      ,/* 接收面額 */
rtjc023       number(20,6)      ,/* 接收面額單位金額 */
rtjc024       number(5,0)      ,/* 接卡券折扣率 */
rtjc025       varchar2(10)      ,/* 來源類型 */
rtjc026       varchar2(20)      ,/* 來源單號 */
rtjc027       varchar2(10)      ,/* 來源折價方式 */
rtjc028       number(20,6)      ,/* 承擔比例 */
rtjc029       varchar2(1)      ,/* 轉費用否 */
rtjcud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
rtjcud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
rtjcud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
rtjcud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
rtjcud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
rtjcud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
rtjcud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
rtjcud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
rtjcud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
rtjcud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
rtjcud011       number(20,6)      ,/* 自定義欄位(數字)011 */
rtjcud012       number(20,6)      ,/* 自定義欄位(數字)012 */
rtjcud013       number(20,6)      ,/* 自定義欄位(數字)013 */
rtjcud014       number(20,6)      ,/* 自定義欄位(數字)014 */
rtjcud015       number(20,6)      ,/* 自定義欄位(數字)015 */
rtjcud016       number(20,6)      ,/* 自定義欄位(數字)016 */
rtjcud017       number(20,6)      ,/* 自定義欄位(數字)017 */
rtjcud018       number(20,6)      ,/* 自定義欄位(數字)018 */
rtjcud019       number(20,6)      ,/* 自定義欄位(數字)019 */
rtjcud020       number(20,6)      ,/* 自定義欄位(數字)020 */
rtjcud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
rtjcud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
rtjcud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
rtjcud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
rtjcud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
rtjcud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
rtjcud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
rtjcud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
rtjcud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
rtjcud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
rtjc103       varchar2(30)      /* 交款單號 */
);
alter table rtjc_t add constraint rtjc_pk primary key (rtjcent,rtjcdocno,rtjcseq,rtjcseq1) enable validate;

create unique index rtjc_pk on rtjc_t (rtjcent,rtjcdocno,rtjcseq,rtjcseq1);

grant select on rtjc_t to tiptop;
grant update on rtjc_t to tiptop;
grant delete on rtjc_t to tiptop;
grant insert on rtjc_t to tiptop;

exit;
